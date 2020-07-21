//
//  EditCardView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/19/20.
//

import SwiftUI

struct EditCardView: View {
    @ObservedObject var vm: FlashcardsVM
    @ObservedObject var card: Card
    @State var sideA: String = ""
    @State var sideB: String = ""
    @Binding var isPresented: Bool
    @State var enabledTags: [Bool] = []
    
    func saveChanges() {
        card.tags.removeAll()
        for i in vm.tags.indices {
            if enabledTags[i] {
                card.tags.append(vm.tags[i])
            }
        }
        
        card.sideA = sideA.trimmingCharacters(in: .whitespaces)
        card.sideB = sideB.trimmingCharacters(in: .whitespaces)
        
        card.objectWillChange.send()
        vm.objectWillChange.send()
    }
    
    init(vm: FlashcardsVM, card: Card, isPresented: Binding<Bool>) {
        self.vm = vm
        self.card = card
        self._isPresented = isPresented
        self._sideA = State(initialValue: card.sideA)
        self._sideB = State(initialValue: card.sideB)
        var stateArray: [Bool] = []
        for tag in vm.tags {
            stateArray.append(card.tags.contains(tag))
        }
        
        self._enabledTags = State(initialValue: stateArray)
    }
    
    var body: some View {
        NavigationView {
            CardMutationView(sideA: $sideA, sideB: $sideB, enabledTags: $enabledTags, tags: vm.tags).navigationBarTitle("Edit Card").navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button("Cancel") {
                            isPresented.toggle()
                        }
                    }
                    
                    ToolbarItem(placement: .automatic) {
                        Button("Save Changes") {
                            saveChanges()
                            isPresented.toggle()
                        }.disabled(sideA.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || sideB.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                }
        }
    }
    
    

}
struct EditCardView_Previews: PreviewProvider {
    static let vm = FlashcardsVM()
    static var previews: some View {
        EditCardView(vm: vm, card: Card(sideA: "A", sideB: "B", tags: [Tag(name: "tag")]), isPresented: .constant(true)).environmentObject(vm)
    }
}
