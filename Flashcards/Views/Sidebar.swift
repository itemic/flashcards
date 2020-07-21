//
//  Sidebar.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/16/20.
//

import SwiftUI

struct Sidebar: View {
    
    @State var disclose = true
    @EnvironmentObject var vm: FlashcardsVM
    var body: some View {
        
        List() {
            
            Group {
                NavigationLink(destination: DetailView()) {
                    Label("Today", systemImage: "sun.max.fill")
                    
                }.listItemTint(.yellow)
                
                Section(header: Text("Modes")){
                    NavigationLink(destination: LibraryView().environmentObject(vm)) {
                    Label("Library", systemImage: "books.vertical.fill")
                }
                
                NavigationLink(destination: TagsView()) {
                    Label("Tags", systemImage: "tag.fill")
                }
                
                NavigationLink(destination: DetailView().environmentObject(vm)) {
                    Label("Stats", systemImage: "chart.bar.xaxis")

                }}
            }
            
            
            
            
                
                Section(header:
                            Text("Tags")
                ) {
                    ForEach(vm.tags) {tag in
                        NavigationLink(destination: LibraryView(filterTag: tag).environmentObject(vm)) {
                            Label("\(tag.name)", systemImage: "square.grid.3x3.fill")
                                

                        }
                    }
                }.listItemTint(.orange)
    
            
            
            
            
            
        }.listStyle(SidebarListStyle())
        .animation(.easeInOut)
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
