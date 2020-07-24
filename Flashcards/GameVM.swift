//
//  GameVM.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/19/20.
//

import Foundation

enum CardDirection {
    case aToB, bToA
}

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
    
    func srsUpdate(quality: Int, direction: CardDirection = .aToB) {
        var card = currentCard!
        var interval, repetitions, encounters: Int
        var ease: Double
        
        if (direction == .aToB) {
            interval = card.abInterval
            repetitions = card.abRepetitions
            ease = card.abEaseFactor
            encounters = card.abEncounters
        } else {
            interval = card.baInterval
            repetitions = card.baRepetitions
            ease = card.baEaseFactor
            encounters = card.baEncounters
        }
        
        if quality >= 3 {
            if repetitions == 0 { interval = 1 }
            else if repetitions == 1 { interval = 6 }
            else { interval = Int(round(Double(repetitions) * ease))}
            repetitions += 1
            
            var easeComponent1 = (5 - Double(quality))
            var easeComponent2 = (0.08 + (5 - Double(quality)) * 0.02)
            
            var easeSum = easeComponent1 * easeComponent2
            
            var newEase = ease + (0.1  - easeSum)
            ease = newEase
            encounters += 1
        } else {
            repetitions += 1
            encounters += 1
            interval = 1
        }
        
        if ease <= 1.3 {ease = 1.3}
        
        if (direction == .aToB) {
            card.abInterval = interval
            card.abRepetitions = repetitions
            card.abEaseFactor = ease
            card.abEncounters = encounters
        } else {
            card.baInterval = interval
            card.baRepetitions = repetitions
            card.baEaseFactor = ease
            card.baEncounters = encounters
        }
        
        card.objectWillChange.send()
    }
    
    // todo
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
