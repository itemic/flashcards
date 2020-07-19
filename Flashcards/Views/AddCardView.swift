//
//  AddCardView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/18/20.
//

import SwiftUI

struct AddCardView: View {
    var vm: FlashcardsVM
    @State var sideA: String = ""
    @State var sideB: String = ""
    @Binding var isPresented: Bool
    @State var enabledTags: [Bool]
    
   
    
    init(vm: FlashcardsVM, isPresented: Binding<Bool>) {
        self.vm = vm
        self._isPresented = isPresented
        var stateArray: [Bool] = []
        for _ in vm.tags {
            stateArray.append(false)
        }
        self._enabledTags = State(initialValue: stateArray)
//        populateEnabledTags()
    }
    
    func processTags() -> [Tag] {
        var tagsToReturn: [Tag] = []
        
        /// to do we need a better process here but for now it works
        
        for i in vm.tags.indices {
            if enabledTags[i] {
                tagsToReturn.append(vm.tags[i])
            }
        }
        
        return tagsToReturn
    }
    
    var body: some View {
        VStack {
            Text("Add New Card")
            Form {
                TextField("Side A", text: $sideA)
                TextField("Side B", text: $sideB)
                
                
                ForEach(vm.tags.indices) {i in
                    Toggle("\(vm.tags[i].name)", isOn: $enabledTags[i])
                }
                
                Button(action: {
                    let card = Card(sideA: sideA, sideB: sideB, tags: processTags())
                    vm.addCard(card: card)
                    isPresented.toggle()
                }) {
                    Text("Add card")
                }
            }
        }
    }
}

struct AddCardView_Previews: PreviewProvider {
    static let vm = FlashcardsVM()
    static var previews: some View {
        AddCardView(vm: vm, isPresented: Binding.constant(true))
    }
}
