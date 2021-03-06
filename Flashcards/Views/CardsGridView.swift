//
//  SwiftUIView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/17/20.
//

import SwiftUI
import Combine


struct CardPartialView: View {
    var sideA: String
    var sideB: String
    @Binding var showFirstSide: Bool
    @Binding var showBothSides: Bool
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                
                if (showBothSides) {
                    Spacer()
                    Text("\(sideA)")
                    Spacer()
                    Divider()
                    Spacer()
                    Text("\(sideB)")
                    Spacer()
                } else {
                    Group {
                        if (showFirstSide) {
                            
                            HStack {
                                
                                Spacer()
                                Text("\(sideA)")
                                Spacer()
                            }
                            
                        } else {
                            HStack {
                                Spacer()
                                Text("\(sideB)")
                                Spacer()
                            }
                        }
                    }
                }
                
                Spacer()
            }.font(.system(size: 24))
            //                .padding()
            
        }.frame(height: 200)
        .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGray6), Color(UIColor.systemGray5)]), startPoint: .top, endPoint: .bottom))
        .overlay(showBothSides ?  AnyView(EmptyView()):
                    AnyView(Text("\(showFirstSide ? "a" : "b" )")
                                .fontWeight(.medium)
                                .padding([.leading, .trailing], 18)
                                .padding([.top, .bottom], 8)
                                .background(Color.black.opacity(0.2))
                                .cornerRadius(200)
                                .padding([.leading, .trailing], 18)
                                .padding([.top, .bottom], 12))
                 ,alignment: .top)
    }
}

struct CardsGridView: View {
    @EnvironmentObject var vm: FlashcardsVM
    @ObservedObject var card: Card
    @Binding var showStats: Bool
    @Binding var showBothSides: Bool
    @State var showFirstSide = true
    @State var showEditView = false
    
    
    func clearAllTags() {
        
        card.tags.removeAll()
        card.objectWillChange.send()
        //bug is that the element doesn't actually delete when viewing from filtered list
    }
    
  
    
    var Stats: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "tag")
                        Text("Tags").fontWeight(.heavy)
                        Spacer()
                        Button(action: {
//                                    clearAllTags()
                            showEditView.toggle()
                            
                        }) {
                            Image(systemName: "pencil")
                            Text("Edit")
                        }.sheet(isPresented: $showEditView) {
                            EditCardView(vm: vm, card: card, isPresented: $showEditView)
                        }
                        .padding([.leading, .trailing], 10)
                        .padding([.top, .bottom], 5)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    }
                    HStack {
                        ForEach(card.tags) {tag in
                            Text(tag.name)
                        }
                    }
                    Text("AB")
                    HStack {
                        Text("Reps \(card.abRepetitions)")
                        Text("Next \(card.abInterval)")
                        Text("Ease \(String(format: "%.2f", card.abEaseFactor))")
                    }.font(.caption)
                    
                }
                Spacer()
            
            }
            .padding()
            Spacer()
            
        }
//        .background(LinearGradient(gradient: Gradient(colors:  [.white]), startPoint: .top, endPoint: .bottom))
        .background(Color.blue)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CardPartialView(sideA: card.sideA, sideB: card.sideB, showFirstSide: $showFirstSide, showBothSides: $showBothSides)
            if showStats {
                Stats
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
        
        CardsGridView(card: Card(sideA: "Side A", sideB: "Side B", tags: [Tag(name: "testTag"), Tag(name: "bestTag")]),showStats: .constant(true), showBothSides: .constant(false))
    }
}
