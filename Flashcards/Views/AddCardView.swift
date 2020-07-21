//
//  AddCardView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/18/20.
//

import SwiftUI

struct AddCardView: View {
    @ObservedObject var vm: FlashcardsVM
    @State var sideA: String = ""
    @State var sideB: String = ""
    @Binding var isPresented: Bool
    @State var enabledTags: [Bool]
    @State var tagsToEnable: [Tag]
    @State var newTagsTextField: String = ""
    @State var showAddTagView: Bool = false
    
    
    
    
    init(vm: FlashcardsVM, isPresented: Binding<Bool>) {
        self.vm = vm
        self._isPresented = isPresented
        
        var stateArray: [Bool] = []
        for _ in vm.tags {
            stateArray.append(false)
        }
        self._enabledTags = State(initialValue: stateArray)
        self._tagsToEnable = State(initialValue: [])
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
        NavigationView {
            CardMutationView(sideA: $sideA, sideB: $sideB, enabledTags: $enabledTags, tags: vm.tags).navigationBarTitle("Add Card").navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button("Cancel") {
                            isPresented.toggle()
                        }
                    }
                    
                    ToolbarItem(placement: .automatic) {
                        Button("Add Card") {
                            let card = Card(sideA: sideA.trimmingCharacters(in: .whitespacesAndNewlines), sideB: sideB.trimmingCharacters(in: .whitespacesAndNewlines), tags: processTags())
                            vm.addCard(card: card)
                            isPresented.toggle()
                        }.disabled(sideA.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || sideB.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                }
        }
    }
    
    
}

struct ButtonToggle: View {
    var name: String
    @Binding var isOn: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "tag.fill")
                VStack(alignment: .leading) {
                    Text("\(name)").bold()
                    //                    Text("Tag").font(.caption)
                }
                Spacer()
            }
            
        }.padding()
        .frame(height: 60)
        .background(isOn ? Color.orange : Color(UIColor.systemFill))
        .cornerRadius(15)
        .onTapGesture {
            isOn.toggle()
        }
        
    }
}

struct AddCardView_Previews: PreviewProvider {
    static let vm = FlashcardsVM()
    static var previews: some View {
        AddCardView(vm: vm, isPresented: Binding.constant(true))
    }
}
