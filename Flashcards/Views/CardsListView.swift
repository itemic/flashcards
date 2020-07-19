//
//  CardsListView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/17/20.
//

import SwiftUI

struct CardsListView: View {
    let card: Card
    let arrows = ["arrow.up.square.fill", "arrow.up.right.square.fill", "arrow.right.square.fill", "arrow.down.right.square.fill", "arrow.down.square.fill"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Image(systemName: arrows.randomElement()!)
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text(card.sideA).font(.headline)
                        Text(card.sideB).font(.headline)
                    }
                    HStack {
                        HStack {
                            Image(systemName: "tag.circle.fill").foregroundColor(.purple).font(.caption)
                            Text("japanese").foregroundColor(.white).font(.caption)
                        }.padding([.leading, .trailing], 5)
                        .padding([.top, .bottom], 2)
                        .background(Color(UIColor.darkGray))
                        .cornerRadius(15)
                        
                        HStack {
                            Image(systemName: "tag.circle.fill").foregroundColor(.purple).font(.caption)
                            Text("lesson-1").foregroundColor(.white).font(.caption)
                        }.padding([.leading, .trailing], 5)
                        .padding([.top, .bottom], 2)
                        .background(Color(UIColor.darkGray))
                        .cornerRadius(15)
                        
                        HStack {
                            Image(systemName: "tag.circle.fill").foregroundColor(.purple).font(.caption)
                            Text("lesson-2").foregroundColor(.white).font(.caption)
                        }.padding([.leading, .trailing], 5)
                        .padding([.top, .bottom], 2)
                        .background(Color(UIColor.darkGray))
                        .cornerRadius(15)
                    }
                }
                
                Spacer()
                HStack {
                    HStack {
                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                        Text("30").foregroundColor(.green)
                    }.padding(5)
                    .background(Color(UIColor.darkGray))
                    .cornerRadius(15)
                    HStack {
                        Image(systemName: "triangle.circle.fill").foregroundColor(.orange)
                        Text("120").foregroundColor(.orange)
                    }.padding(5)
                    .background(Color(UIColor.darkGray))
                    .cornerRadius(15)
                }
            }
            
            
        }.padding(10)
        .background(Color.gray)
        .cornerRadius(10.0)
    }
}

struct CardsListView_Previews: PreviewProvider {
    static var previews: some View {
        
        CardsListView(card: Card(sideA: "Side A", sideB: "Side B", tags: []))
    }
}
