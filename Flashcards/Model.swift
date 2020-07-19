//
//  Model.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/16/20.
//

import Foundation

struct Card: Identifiable {
    let id = UUID()
    var sideA: String
    var sideB: String
    var tags: [Tag] = []
    
    mutating func assignTag(tag: Tag...) {
        tags.append(contentsOf: tag)
    }
}

class Tag: Identifiable, Equatable {
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        return lhs.name == rhs.name
    }
    
    let id = UUID()
    let name: String
    
    init(name: String) {
        self.name = name
        print("creating tag...\(self.id)...\(self.name)")

    }
    
}
