//
//  TodayView.swift
//  Flashcards
//
//  Created by Terran Kroft on 8/2/20.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject var vm: FlashcardsVM
    var newCardsCount = 5 //need to put in settings
    
    func getGameModel() -> GameVM {
        print(vm.cardsDueToday)
        return GameVM(cards: vm.cardsDueToday)
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.tertiarySystemFill).edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    VStack(alignment:.leading, spacing: 10) {
                        ReviewTextStructureView(new: newCardsCount, rev: vm.cardsDueToday.count).font(.system(size: 32, weight: .regular, design: .rounded))
                        
                        HStack(spacing: 10) {
                            NavigationLink(destination: PracticeModeView(gameVM: GameVM(cards: vm.cardsDueToday))) {
                                HStack {
                                    Spacer()
                                    Text("Practice")
                                    Spacer()
                                }
                            }.foregroundColor(.white)
                            .padding([.top, .bottom], 10)
                            .padding([.leading, .trailing], 10)
                            .background(Color.blue)
                            .cornerRadius(15)
                            
                            Button(action: {}) {
                                HStack{
                                    
                                    Text("Ignore (Procrastinate)").bold()
                                    
                                }
                            }.foregroundColor(.white)
                            .padding([.top, .bottom], 10)
                            .padding([.leading, .trailing], 10)
                            .background(Color.gray)
                            .cornerRadius(15)
                        }
                    }
                    
                        Spacer()

                }
                .padding()
                .background(Color(UIColor.quaternarySystemFill))
                .cornerRadius(15)
                Spacer()
                
            }.padding()
            .navigationTitle("Today")
        }
        
        
    }
}

struct ReviewTextStructureView: View {
    var new: Int
    var rev: Int

    var body: some View {
        Text("You have ") +
            Text("\(rev) card\(rev == 1 ? "" : "s") to review").foregroundColor(.orange).fontWeight(.semibold) +
            Text(" and ") +
            Text("\(new) new card\(new == 1 ? "" : "s") to learn").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).fontWeight(.semibold) +
            Text(".")
    }
    
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
