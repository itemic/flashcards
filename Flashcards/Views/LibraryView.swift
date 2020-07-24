//
//  CardsView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/16/20.
//

import SwiftUI





struct LibraryView: View {
    
    
    @State var showStats = false
    @State var showBothSides = true
    @State var showAddCardSheet = false
    var filterTag: Tag?
    var filterUnfiltered: Bool?
    @EnvironmentObject var vm: FlashcardsVM
    
    
    let columns = [
        GridItem(.adaptive(minimum: 190, maximum: 220))
        ]
    
    var body: some View {
        ScrollView {

                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(vm.cards.filter {
                        
                        filterUnfiltered == true ? $0.tags.isEmpty : filterTag == nil ? true : $0.tags.contains(filterTag!)
                 
                        
                        
                    }) { item in
                        CardsGridView(card: item, showStats: $showStats, showBothSides: $showBothSides).environmentObject(vm)
                            
                    }
                }.padding()
            
            
        }.navigationTitle("Library").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
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



