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
    var tags: [Tag]? = []
}

struct Tag: Identifiable {
    let id = UUID()
    let name: String
}
