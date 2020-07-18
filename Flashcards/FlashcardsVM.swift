//
//  CardsVM.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/17/20.
//

import Foundation

class FlashcardsVM: ObservableObject {
    @Published var words: [Card] = [
        Card(sideA: "spring", sideB: "春", tags: []),
        Card(sideA: "summer", sideB: "夏", tags: []),
        Card(sideA: "fall", sideB: "秋", tags: []),
        Card(sideA: "winter", sideB: "冬", tags: []),
        Card(sideA: "bicycle", sideB: "自転車", tags: []),
        Card(sideA: "homework", sideB: "宿題", tags: []),
        Card(sideA: "doctor", sideB: "医者", tags: []),
        Card(sideA: "surgery", sideB: "手術", tags: []),
        Card(sideA: "ticket gate", sideB: "改札", tags: []),
        Card(sideA: "antibiotics", sideB: "抗生物質", tags: []),
        Card(sideA: "nurse", sideB: "看護師", tags: []),
        Card(sideA: "store", sideB: "売店", tags: []),
        Card(sideA: "stairs", sideB: "階段", tags: []),
        Card(sideA: "season", sideB: "季節", tags: []),
        Card(sideA: "to travel", sideB: "旅行する", tags: []),
        Card(sideA: "to run", sideB: "走る", tags: []),
        Card(sideA: "blue", sideB: "青い", tags: []),
        Card(sideA: "red", sideB: "赤い", tags: []),
        Card(sideA: "green", sideB: "緑", tags: []),
        Card(sideA: "yellow", sideB: "黄色い", tags: []),
        Card(sideA: "to have", sideB: "持つ", tags: []),
        Card(sideA: "letter", sideB: "手紙", tags: []),
        Card(sideA: "injection", sideB: "注射", tags: []),
        Card(sideA: "water", sideB: "水", tags: []),
        Card(sideA: "sea", sideB: "海", tags: []),
        Card(sideA: "river", sideB: "川", tags: []),
        Card(sideA: "back", sideB: "背中", tags: []),
        Card(sideA: "leg", sideB: "足", tags: []),
        Card(sideA: "finger", sideB: "指", tags: []),
        Card(sideA: "ring", sideB: "指輪", tags: []),
        Card(sideA: "warm", sideB: "暖かい", tags: []),
        Card(sideA: "cold", sideB: "寒い", tags: []),
        Card(sideA: "hot", sideB: "暑い", tags: []),
        Card(sideA: "cool", sideB: "涼しい", tags: []),
        Card(sideA: "to forget", sideB: "忘れる", tags: []),
        Card(sideA: "to die", sideB: "死ぬ", tags: []),
        Card(sideA: "to practice", sideB: "練習する", tags: []),
        Card(sideA: "actor", sideB: "俳優", tags: []),
        Card(sideA: "family", sideB: "家族", tags: []),
        Card(sideA: "cloudy", sideB: "曇り", tags: []),
        Card(sideA: "sunny", sideB: "晴れ", tags: [])
    ]
    
    @Published var tags: [Tag] = [
        Tag(name: "japanese"),
        Tag(name: "verb"),
        Tag(name: "adjective")
    ]
    
    /// Create new tag
    func addTag(tag: Tag...) {
        tags.append(contentsOf: tag)
    }
    
    /// Create new card
    func addCard(card: Card) -> () {
        words.append(card)
    }

}
