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
            PrimaryView().environmentObject(vm)
            
        }
//        Text("Hello, world!").padding()
    }
}



struct PrimaryView: View {
    @EnvironmentObject var vm: FlashcardsVM
    var body: some View {
        TodayView().environmentObject(vm)
    }
}

struct DetailView: View {
    @EnvironmentObject var vm: FlashcardsVM
    func getGameModel() -> GameVM {
        return GameVM(cards: vm.cards)
    }
    var body: some View {
        Text("Detail")
        NavigationLink(destination: PracticeModeView(gameVM: getGameModel())) {
            Text("Practice")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
