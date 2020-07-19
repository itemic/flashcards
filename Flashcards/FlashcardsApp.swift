//
//  FlashcardsApp.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/16/20.
//

import SwiftUI

@main
struct FlashcardsApp: App {
    var vm = FlashcardsVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(vm)
        }
    }
}
