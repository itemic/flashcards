//
//  Model.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/16/20.
//

import Foundation

class Card: Identifiable, ObservableObject, Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    var sideA: String
    var sideB: String
    var tags: [Tag] = []
    
    // A -> B
    var abRepetitions: Int
    var abEaseFactor: Double
    var abInterval: Int
    var abEncounters: Int // total times completed
    
    var baRepetitions: Int
    var baEaseFactor: Double
    var baInterval: Int
    var baEncounters: Int
    
    init(sideA: String, sideB: String, tags: [Tag]) {
        self.sideA = sideA
        self.sideB = sideB
        self.tags = tags
        
        self.abRepetitions = 0
        self.abEaseFactor = 2.5
        self.abInterval = 0
        self.abEncounters = 0
        
        self.baRepetitions = 0
        self.baEaseFactor = 2.5
        self.baInterval = 0
        self.baEncounters = 0
    }
    
    
    
    func assignTag(tag: Tag...) {
        tags.append(contentsOf: tag)
    }
}

class Tag: Identifiable, Equatable, ObservableObject {
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        return lhs.name.lowercased() == rhs.name.lowercased() // primary key
    }
    
    let id = UUID()
    let name: String
    
    init(name: String) {
        self.name = name
        print("creating tag...\(self.id)...\(self.name)")
        

    }
    
}


class Level {
    var levelCards: [Card]
    
    init(cards: [Card]) {
        self.levelCards = cards 
    }
}
