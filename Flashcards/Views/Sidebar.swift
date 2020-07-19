//
//  Sidebar.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/16/20.
//

import SwiftUI

struct Sidebar: View {
    
    @State var disclose = true
    @ObservedObject var tagsVM = FlashcardsVM()
    var body: some View {
        
        List() {
            
            Group {
                NavigationLink(destination: DetailView()) {
                    Label("Today", systemImage: "calendar.badge.clock")
                    
                }
                
                NavigationLink(destination: LibraryView()) {
                    Label("Library", systemImage: "books.vertical.fill")
                }
                
                NavigationLink(destination: TagsView()) {
                    Label("Tags", systemImage: "tag.fill")
                }
                
                NavigationLink(destination: DetailView()) {
                    Label("Stats", systemImage: "chart.bar.xaxis")

                }
            }
            
            Divider()
            
            DisclosureGroup("Tags", isExpanded: $disclose) {
                
                ForEach(tagsVM.tags) {tag in
                    NavigationLink(destination: LibraryView(filterVar: tag.name)) {
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
