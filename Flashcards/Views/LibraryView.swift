//
//  CardsView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/16/20.
//

import SwiftUI





struct LibraryView: View {
    
    @State var showGridView = true
    @State var showStats = false
    @State var showBothSides = true
    @State var showAddCardSheet = false
    @ObservedObject var vm = FlashcardsVM()
    
    
    let columns = [
        GridItem(.adaptive(minimum: 190, maximum: 220))
        ]
    
    var body: some View {
        ScrollView {
            if showGridView {
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(vm.words) { item in
                        CardsGridView(card: item, showStats: $showStats, showBothSides: $showBothSides)
                            
                    }
                }.padding()
            } else {
                LazyVStack(spacing: 10) {
                    ForEach(vm.words) { item in
                        CardsListView(card: item)
                    }
                }.padding()
            }
            
        }.navigationTitle("Library")
        .toolbar {
            
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    showGridView.toggle()
                }, label: {
                    Text("Side")
                    Image(systemName: "\(showGridView ? "a.square" : "b.square")")
                })
                        }
            
            ToolbarItem(placement: .automatic) {

                Button(action: {
                    withAnimation {
                        showStats.toggle()
                    }
                }, label: {
                    Image(systemName: "chart.bar.fill")
                    Text("Stats")
                })
            }

            ToolbarItem(placement: .automatic) {
                
                Button(action: {
                    withAnimation {
                        showBothSides.toggle()
                    }
                }, label: {
                    Image(systemName: "square.on.square")
                    Text("A/B")
                    
                })
            }
            
            ToolbarItem(placement: .automatic) {
                
                Button(action: {
                    withAnimation {
                        showAddCardSheet.toggle()
                    }
                }, label: {
                    Image(systemName: "plus.rectangle.on.rectangle")
                    Text("Add Card")
                    
                }).sheet(isPresented: $showAddCardSheet) {
                    AddCardView(vm: vm, isPresented: $showAddCardSheet)
                }
            }

        }
        
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}



