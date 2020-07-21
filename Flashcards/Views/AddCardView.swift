//
//  AddCardView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/18/20.
//

import SwiftUI

struct AddCardView: View {
    @ObservedObject var vm: FlashcardsVM
    @State var sideA: String = ""
    @State var sideB: String = ""
    @Binding var isPresented: Bool
    @State var enabledTags: [Bool]
    @State var newTagsTextField: String = ""
    @State var showAddTagView: Bool = false
   
    
    init(vm: FlashcardsVM, isPresented: Binding<Bool>) {
        self.vm = vm
        self._isPresented = isPresented
        var stateArray: [Bool] = []
        for _ in vm.tags {
            stateArray.append(false)
        }
        self._enabledTags = State(initialValue: stateArray)
//        populateEnabledTags()
    }
    
    func processTags() -> [Tag] {
        var tagsToReturn: [Tag] = []
        
        /// to do we need a better process here but for now it works
        
        for i in vm.tags.indices {
            if enabledTags[i] {
                tagsToReturn.append(vm.tags[i])
            }
        }
        
        return tagsToReturn
    }
    
    var body: some View {
        NavigationView {
            internals.navigationBarTitle("Add Card").navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button("Cancel") {
                            isPresented.toggle()
                        }
                    }
                    
                    ToolbarItem(placement: .automatic) {
                        Button("Add Card") {
                            let card = Card(sideA: sideA, sideB: sideB, tags: processTags())
                            vm.addCard(card: card)
                            isPresented.toggle()
                        }
                    }
                }
        }
    }
    var internals: some View {
        
        ScrollView {
        HStack {
            VStack(alignment: .leading, spacing: 20) {

                HStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 0) {
                        Spacer()
                        Text("Side A").font(.caption)
                        TextField("Tap to add Side A", text: $sideA).font(.title).multilineTextAlignment(.center)
                        Spacer()
                        Divider()
                        Spacer()
                        Text("Side B").font(.caption)
                        TextField("Tap to add Side B", text: $sideB).font(.title).multilineTextAlignment(.center)
                        Spacer()
                    }.padding()
                    .frame(width: 300, height: 300)
                    .background(LinearGradient(gradient: Gradient(colors:  [Color(UIColor.systemGray6), Color(UIColor.systemGray5)]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(30)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 10)
                    Spacer()
                }.padding(30).background(Color.white)
                
                VStack(alignment: .leading) {
                
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 250))], spacing: 15) {
                        ForEach(vm.tags.indices) {i in
                            ButtonToggle(name: "\(vm.tags[i].name)", isOn: $enabledTags[i])
                        }
                        
                        
                        // Start {Add tag}
                        VStack {
                            HStack {
                                Image(systemName: "plus.diamond.fill")
                                VStack(alignment: .leading) {
                                    Text("Add Tags...").fontWeight(.medium)
//                                    Text("").font(.caption)
                                }
                                Spacer()
                            }
                                    
                        }.padding()
                        .frame(height: 60)
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(15)
                        .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .strokeBorder(
                                            style: StrokeStyle(
                                                lineWidth: 1,
                                                dash: [10]
                                            )
                                        )
                                        .foregroundColor(.secondary)
                                )
                        .onTapGesture {
                            showAddTagView.toggle()
                            newTagsTextField = ""
                        }.popover(isPresented: $showAddTagView, content: {
                            AddTagsPopoverView(textField: $newTagsTextField, showAddTagsPopover: $showAddTagView).environmentObject(vm)
                            
                        })
                        // End {Add tag}
                        
                        
                    }
                    Text("Add a few tags to organize your cards").font(.caption).foregroundColor(.secondary)
                    
                
                }.padding([.leading, .trailing])
            
                
            }
            
            
        }
        }.background(Color(UIColor.systemGroupedBackground))

    }

}

struct ButtonToggle: View {
    var name: String
    @Binding var isOn: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "tag.fill")
                VStack(alignment: .leading) {
                Text("\(name)").bold()
//                    Text("Tag").font(.caption)
                }
                Spacer()
            }
                    
        }.padding()
        .frame(height: 60)
        .background(isOn ? Color.orange : Color.white)
        .cornerRadius(15)
        .onTapGesture {
            isOn.toggle()
        }
        
    }
}

struct AddCardView_Previews: PreviewProvider {
    static let vm = FlashcardsVM()
    static var previews: some View {
        AddCardView(vm: vm, isPresented: Binding.constant(true)).internals
    }
}
