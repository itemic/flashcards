//
//  SwiftUIView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/17/20.
//

import SwiftUI
import Combine

struct CardsGridView: View {
    @EnvironmentObject var vm: FlashcardsVM
    @ObservedObject var card: Card
    @Binding var showStats: Bool
    @Binding var showBothSides: Bool
    @State var showFirstSide = true
    @State var showEditView = false
    let grayGradient = [Color(UIColor.systemGray6), Color(UIColor.systemGray5)]
    
    func clearAllTags() {
        
        card.tags.removeAll()
        card.objectWillChange.send()
        //bug is that the element doesn't actually delete when viewing from filtered list
    }
    
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
                        
                        Group {
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
                //                .padding()
                
            }.frame(height: 200)
            .background(LinearGradient(gradient: Gradient(colors: grayGradient), startPoint: .top, endPoint: .bottom))
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
            ///TODO don't use type erasure
            if showStats {
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
                            
                        }
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
        
        CardsGridView(card: Card(sideA: "Side A", sideB: "Side B", tags: [Tag(name: "testTag"), Tag(name: "bestTag")]),showStats: .constant(true), showBothSides: .constant(false))
    }
}
