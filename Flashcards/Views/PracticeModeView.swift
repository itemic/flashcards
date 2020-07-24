//
//  PracticeModeView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/19/20.
//

import SwiftUI

struct PracticeModeView: View {
    
    @State var flipped = false
    @ObservedObject var gameVM: GameVM
    @State var gameOver = false
    
    func nextCard() {
        gameVM.getNextWord()
        flipped.toggle()
        if gameVM.isGameOver() {
            gameOver = true
        }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 36) {
                Text("Remaining: \(gameVM.size)")
                ZStack {
                    
                    Text("").font(.system(size: 36))
                        .padding()
                        .frame(width:300, height: 300)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGray5), Color(UIColor.systemGray6)]), startPoint: .top, endPoint: .bottom))
                        //                .background(flipped ? Color.red : Color.blue)
                        .cornerRadius(30)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 10)
                    //                    .rotation3DEffect(self.flipped ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(-1), y: CGFloat(0), z: CGFloat(0)))
                    //                    .animation(.easeIn)
                    Text(gameVM.currentCard?.sideA ?? "--").font(.system(size: 36)).zIndex(self.flipped ? -1 : 1)
                    Text(gameVM.currentCard?.sideB ?? "--" ).font(.system(size: 36)).zIndex(self.flipped ? 1 : -1)
                }
                
                if flipped {
                    HStack {
                        Button("Again") {
                            flipped.toggle()
                        }.padding()
                        .frame(minWidth: 100)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(24)
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                        
                        Button("Hard") {
                            
                            gameVM.srsUpdate(quality: 2)
                            nextCard()
                        }.padding()
                        .frame(minWidth: 100)
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(24)
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                        
                        Button("Good") {
                            
                            gameVM.srsUpdate(quality: 4)
                            nextCard()
                        }.padding()
                        .frame(minWidth: 100)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(24)
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                        
                        Button("Easy") {
                            
                            gameVM.srsUpdate(quality: 5)
                            nextCard()
                        }.padding()
                        .frame(minWidth: 100)
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(24)
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                    }
                } else {
                    Button("Show Answer") {
                        flipped.toggle()
                    }.padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(24)
                    .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                }
                
                
                
            }
            
            }
        if gameOver {
        GeometryReader { geo in
            Text("Game Over")
                .frame(width: geo.size.width, height: geo.size.height)
                .background(Color.red)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        }
    }
}

struct PracticeModeView_Previews: PreviewProvider {
    static var vm = GameVM(cards: [Card(sideA: "Side A", sideB: "Side B", tags: [])])
    static var previews: some View {
        PracticeModeView(gameVM: vm)
    }
}
