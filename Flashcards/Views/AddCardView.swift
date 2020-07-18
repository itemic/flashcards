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
    
    var body: some View {
        VStack {
            Text("Add New Card")
            Form {
                TextField("Side A", text: $sideA)
                TextField("Side B", text: $sideB)
                Button(action: {
                    let card = Card(sideA: sideA, sideB: sideB, tags: [])
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
        AddCardView(vm: vm, isPresented: .constant(true))
    }
}
