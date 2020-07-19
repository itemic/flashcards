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
    
    init(sideA: String, sideB: String, tags: [Tag]) {
        self.sideA = sideA
        self.sideB = sideB
        self.tags = tags
    }
    
    
    
    func assignTag(tag: Tag...) {
        tags.append(contentsOf: tag)
    }
}

class Tag: Identifiable, Equatable, ObservableObject {
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        return lhs.id == rhs.id
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
