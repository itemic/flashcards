//
//  CardMutationView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/21/20.
//

import SwiftUI

enum CardChange {
    case removed, added, nochange
}

struct CardMutationView: View {
    
    @Binding var sideA: String
    @Binding var sideB: String
    @Binding var enabledTags: [Bool]
  
    var editMode: Bool
    var tags: [Tag]
    
    var originalSideA: String?
    var originalSideB: String?
    var originalCard: Card?
    
    init(sideA: Binding<String>, sideB: Binding<String>, enabledTags: Binding<[Bool]>, tags: [Tag], editTags: Card? = nil) {
        self._sideA = sideA
        self._sideB = sideB
        self._enabledTags = enabledTags
        
        self.tags = tags
        
        if editTags != nil {
            self.editMode = true
            self.originalSideA = sideA.wrappedValue
            self.originalSideB = sideB.wrappedValue
            self.originalCard = editTags!
        } else {
            self.editMode = false

        }
    }
    
    func getChangeOfTagStatus(tag: Tag) -> CardChange {
        guard let originalCard = originalCard else {
            return .nochange
        }
        
        let oBool = originalCard.tags.contains(tag)
        let cBool = enabledTags[tags.firstIndex(of: tag)!]
        
        print("\(oBool) is then \(cBool)")
        
        if oBool && !cBool {
            return .removed
        }
        
        if !oBool && cBool {
            return .added
        }
        
        
        return .nochange
    }
    
    var body: some View {
        
        ScrollView {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    
                    HStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 0) {
                            Spacer()
                            Text("Side A").font(.caption)
                            TextField("Tap to add Side A", text: $sideA).font(.system(size: 24)).multilineTextAlignment(.center)
                            Spacer()
                            Divider()
                            Spacer()
                            Text("Side B").font(.caption)
                            TextField("Tap to add Side B", text: $sideB).font(.system(size: 24)).multilineTextAlignment(.center)
                            Spacer()
                        }.padding()
                        .frame(width: 300, height: 300)
                        .background(LinearGradient(gradient: Gradient(colors:  [Color(UIColor.systemGray6), Color(UIColor.systemGray5)]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(30)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 10)
                        Spacer()
                    }.padding(30).background(Color(UIColor.systemBackground))
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("TAGS").font(.headline)
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 250))], spacing: 15) {
                            //                            ForEach(vm.tags.indices) {i in
                            //                                ButtonToggle(name: "\(vm.tags[i].name)", isOn: $enabledTags[i])
                            //                            }
                            
                            ForEach(tags, id: \.name) {tag in
                                ButtonToggle(name: "\(tag.name)", isOn:
                                                $enabledTags[tags.firstIndex(of: tag)!])
                            }
                            
                            
                            
                            ///                             Start {Add tag}
                            //                            VStack {
                            //                                HStack {
                            //                                    Image(systemName: "plus.diamond.fill")
                            //                                    VStack(alignment: .leading) {
                            //                                        Text("Add Tags...").fontWeight(.medium)
                            //                                        //                                    Text("").font(.caption)
                            //                                    }
                            //                                    Spacer()
                            //                                }
                            //
                            //                            }.padding()
                            //                            .frame(height: 60)
                            //                            .background(Color(UIColor.systemGray5))
                            //                            .cornerRadius(15)
                            //                            .overlay(
                            //                                RoundedRectangle(cornerRadius: 15)
                            //                                    .strokeBorder(
                            //                                        style: StrokeStyle(
                            //                                            lineWidth: 1,
                            //                                            dash: [10]
                            //                                        )
                            //                                    )
                            //                                    .foregroundColor(.secondary)
                            //                            )
                            //                            .onTapGesture {
                            //                                showAddTagView.toggle()
                            //                                newTagsTextField = ""
                            //                            }.popover(isPresented: $showAddTagView, content: {
                            //                                AddTagsPopoverView(textField: $newTagsTextField, showAddTagsPopover: $showAddTagView).environmentObject(vm)
                            //
                            //                            })
                            /// End {Add tag}
                            
                            
                        }
                        Text("Add a few tags to organize your cards").font(.caption).foregroundColor(.secondary)
                        
                        if editMode {
                            Group {
                                Text("CHANGES").font(.headline)
                                if sideA != originalCard!.sideA {
                                    Text("Side A: \(originalCard!.sideA) → \(sideA)")
                                }
                                if sideB != originalCard!.sideB {
                                    Text("Side B: \(originalCard!.sideB) → \(sideB)")
                                }
                                
                                ForEach(tags, id: \.name) {tag in
                                    switch getChangeOfTagStatus(tag: tag) {
                                    case .added:
                                        Text("Added tag \(tag.name)")
                                    case .removed:
                                        Text("Removed tag \(tag.name)")
                                    case .nochange:
                                        EmptyView()
                                    }
                                }
                            }
                        }
                        
                    }.padding([.leading, .trailing])
                    
                    
                }
                
                
            }
        }.background(Color(UIColor.secondarySystemBackground))
       
        
    }
    
}

struct CardMutationView_Previews: PreviewProvider {
    static let vm = FlashcardsVM()
    @State static var a: String = "A"
    @State static var b: String = "B"
    static var previews: some View {
        CardMutationView(sideA: $a, sideB: $b, enabledTags: .constant([false, false, false]), tags: vm.tags, editTags: nil)
    }
}
