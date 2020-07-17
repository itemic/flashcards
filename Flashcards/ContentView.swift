//
//  ContentView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/16/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Sidebar()
                .navigationTitle("Flashcards")
            PrimaryView()
            
        }
//        Text("Hello, world!").padding()
    }
}

struct SideBar: View {
    var body: some View {
        List(1..<100) { i in
            Image(systemName: "circle.fill")
            Text("Item \(i)")
        }.listStyle(SidebarListStyle())
    }
}

struct PrimaryView: View {
    var body: some View {
        Text("hello world").padding()
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
