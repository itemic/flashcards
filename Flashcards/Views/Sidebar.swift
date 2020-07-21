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
        
        List {
            
            Group {
                NavigationLink(destination: DetailView()) {
                    Label("Today", systemImage: "sun.max")
                    
                }.listItemTint(.yellow)
                
                Section(header: Text("Modes")){
                    NavigationLink(destination: LibraryView().environmentObject(vm)) {
                    Label("Library", systemImage: "books.vertical")
                }
                
                NavigationLink(destination: TagsView()) {
                    Label("Tags", systemImage: "tag")
                }
                
                NavigationLink(destination: DetailView().environmentObject(vm)) {
                    Label("Stats", systemImage: "chart.bar")

                }}
            }
            
            
            
            
                
                Section(header:
                            Text("Tags")
                ) {
                    ForEach(vm.tags) {tag in
                        NavigationLink(destination: LibraryView(filterTag: tag).environmentObject(vm)) {
                            Label("\(tag.name)", systemImage: "square.grid.3x3")
                        }
                    }
                    
                    
                        NavigationLink(destination: LibraryView(filterUnfiltered: true).environmentObject(vm)) {
                            Label("Uncategorized", systemImage: "tag.slash")
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
