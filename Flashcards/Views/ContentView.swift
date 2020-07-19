//
//  ContentView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/16/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: FlashcardsVM
    var body: some View {
        NavigationView {
            Sidebar()
                .navigationTitle("Flashcards")
                .environmentObject(vm)
            PrimaryView()
            
        }
//        Text("Hello, world!").padding()
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
