//
//  SwiftUIView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/17/20.
//

import SwiftUI

struct CardsGridView: View {
    let card: Card
    @Binding var showStats: Bool
    @Binding var showBothSides: Bool
    @State var showFirstSide = true
    let grayGradient = [Color(UIColor.systemGray6), Color(UIColor.systemGray5)]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                VStack {
                    Spacer()
                    
                    if (showBothSides) {
                        Text("\(card.sideA)")
                        Divider()
                        Text("\(card.sideB)")
                    } else {
                        ZStack {
                            HStack {
                                Text("\(showFirstSide ? "A" : "B")").font(.system(size:180))
                                    .foregroundColor(Color.white.opacity(0.1))
                                Spacer()
                            }
                        if (showFirstSide) {
                            
                            HStack {
                                
                                Spacer()
                                Text("\(card.sideA)")
                                Spacer()
                            }
                            
                        } else {
                            HStack {
                                Spacer()
                                Text("\(card.sideB)")
                                Spacer()
                            }
                        }
                    }
                    }
                    
                    Spacer()
                }.font(.system(size: 24))
                .padding()
                
            }.frame(height: 200)
            .background(LinearGradient(gradient: Gradient(colors: grayGradient), startPoint: .top, endPoint: .bottom))
            if showStats {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Bottom Part").fontWeight(.heavy)
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }.frame(height: 100)
                .background(LinearGradient(gradient: Gradient(colors:  [.white]), startPoint: .top, endPoint: .bottom))
            }
            
            
        }
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 10)
        .onTapGesture {
            if !showBothSides {
                showFirstSide.toggle()
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CardsGridView(card: Card(sideA: "Side A", sideB: "Side B"),showStats: .constant(true), showBothSides: .constant(false))
    }
}
