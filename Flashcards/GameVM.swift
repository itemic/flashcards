//
//  GameVM.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/19/20.
//

import Foundation

class GameVM: ObservableObject {
    @Published var cards: [Card]
    @Published var currentCard: Card?
    @Published var viewedWords: [Card] = []
    
    
    var size: Int {
        return cards.count
    }
    
    init(cards: [Card]) {
        self.cards = cards
        self.currentCard = cards.randomElement()!
    }
    
    // tod o
    func getNextWord() -> Bool {
        if size > 0 {
            cards.remove(at: cards.firstIndex(of: currentCard!)!)
            viewedWords.append(currentCard!)
            currentCard = cards.randomElement()
        } else {
//            cards.remove(at: cards.firstIndex(of: currentCard!)!)
//            viewedWords.append(currentCard!)
        }
        return isGameOver()
    }
    
    func isGameOver() -> Bool {
        return size <= 0
    }
    
    
    
}
