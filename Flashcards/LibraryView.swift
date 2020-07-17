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
    @ObservedObject var vm = CardsVM()
    
    
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
                    Text("Show/Hide Stats")
                    Image(systemName: "chart.bar.fill")
                })
            }
            
            ToolbarItem(placement: .automatic) {
                
                Button(action: {
                    withAnimation {
                        showBothSides.toggle()
                    }
                }, label: {
                    Text("A/B")
                    Image(systemName: "square.on.square")
                })
            }
        }
        
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}



