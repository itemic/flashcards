//
//  Sidebar.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/16/20.
//

import SwiftUI

struct Sidebar: View {
    
    @State var disclose = true
    var body: some View {
        
        List() {
            
            Group {
                NavigationLink(destination: DetailView()) {
                    Label("Today", systemImage: "calendar.badge.clock")
                    
                }
                
                NavigationLink(destination: LibraryView()) {
                    Label("Library", systemImage: "books.vertical.fill")
                }
                
                NavigationLink(destination: DetailView()) {
                    Label("Stats", systemImage: "chart.bar.xaxis")

                }
            }
            
            Divider()
            
            DisclosureGroup("Tags", isExpanded: $disclose) {
                NavigationLink(destination: DetailView()) {
                    Label("Biology", systemImage: "square.grid.3x3.fill")
                        

                }
                NavigationLink(destination: DetailView()) {
                    Label("Org Chem", systemImage: "square.grid.3x3.fill")
                        

                }
                NavigationLink(destination: DetailView()) {
                    Label("Calculus", systemImage: "square.grid.3x3.fill")
                        

                }
                NavigationLink(destination: DetailView()) {
                    Label("Category ", systemImage: "square.grid.3x3.fill")
                        
                }

                NavigationLink(destination: DetailView()) {
                    Label("Shakespeare", systemImage: "square.grid.3x3.fill")
                        

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
