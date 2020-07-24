//
//  CardsVM.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/17/20.
//

import Foundation
import Combine

class FlashcardsVM: ObservableObject {
    @Published var cards: [Card] = [] {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    @Published var tags: [Tag] = [] {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    init() {
        let t1 = Tag(name: "japanese")
        let t2 = Tag(name: "verb")
        let t3 = Tag(name: "adjective")
        
        tags.append(contentsOf: [t1, t2, t3])
        
        cards = [
        Card(sideA: "spring", sideB: "春", tags: [t1]),
        Card(sideA: "summer", sideB: "夏", tags: [t1]),
        Card(sideA: "fall", sideB: "秋", tags: [t1]),
        Card(sideA: "winter", sideB: "冬", tags: [t1]),
        Card(sideA: "bicycle", sideB: "自転車", tags: [t1]),
        Card(sideA: "homework", sideB: "宿題", tags: [t1]),
        Card(sideA: "doctor", sideB: "医者", tags: [t1]),
        Card(sideA: "surgery", sideB: "手術", tags: [t1]),
        Card(sideA: "ticket gate", sideB: "改札", tags: [t1]),
        Card(sideA: "antibiotics", sideB: "抗生物質", tags: [t1]),
        Card(sideA: "nurse", sideB: "看護師", tags: [t1]),
        Card(sideA: "store", sideB: "売店", tags: [t1]),
        Card(sideA: "stairs", sideB: "階段", tags: [t1]),
        Card(sideA: "season", sideB: "季節", tags: [t1]),
        Card(sideA: "to travel", sideB: "旅行する", tags: [t1, t2]),
        Card(sideA: "to run", sideB: "走る", tags: [t1, t2]),
        Card(sideA: "blue", sideB: "青い", tags: [t1, t3]),
        Card(sideA: "red", sideB: "赤い", tags: [t1, t3]),
        Card(sideA: "green", sideB: "緑", tags: [t1, t3]),
        Card(sideA: "yellow", sideB: "黄色い", tags: [t1, t3]),
        Card(sideA: "to have", sideB: "持つ", tags: [t1, t2]),
        Card(sideA: "letter", sideB: "手紙", tags: [t1]),
        Card(sideA: "injection", sideB: "注射", tags: [t1]),
        Card(sideA: "water", sideB: "水", tags: [t1]),
        Card(sideA: "sea", sideB: "海", tags: [t1]),
        Card(sideA: "river", sideB: "川", tags: [t1]),
        Card(sideA: "back", sideB: "背中", tags: [t1]),
        Card(sideA: "leg", sideB: "足", tags: [t1]),
        Card(sideA: "finger", sideB: "指", tags: [t1]),
        Card(sideA: "ring", sideB: "指輪", tags: [t1]),
        Card(sideA: "warm", sideB: "暖かい", tags: [t1, t3]),
        Card(sideA: "cold", sideB: "寒い", tags: [t1, t3]),
        Card(sideA: "hot", sideB: "暑い", tags: [t1, t3]),
        Card(sideA: "cool", sideB: "涼しい", tags: [t1, t3]),
        Card(sideA: "to forget", sideB: "忘れる", tags: [t1, t2]),
        Card(sideA: "to die", sideB: "死ぬ", tags: [t1, t2]),
        Card(sideA: "to practice", sideB: "練習する", tags: [t1, t2]),
        Card(sideA: "actor", sideB: "俳優", tags: [t1]),
        Card(sideA: "family", sideB: "家族", tags: [t1]),
        Card(sideA: "cloudy", sideB: "曇り", tags: [t1]),
        Card(sideA: "sunny", sideB: "晴れ", tags: [t1])
        ]
        
    }
    
    /// Create new tag
    func addTag(tag: Tag...) {
        for t in tag {
            if !tags.contains(t) {
                tags.append(t)
            }
        }
    }
    
    /// Create new card
    func addCard(card: Card) -> () {
        cards.append(card)
    }
    

}
