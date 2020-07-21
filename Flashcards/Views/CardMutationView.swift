//
//  CardMutationView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/21/20.
//

import SwiftUI

struct CardMutationView: View {
    
    @Binding var sideA: String
    @Binding var sideB: String
    @Binding var enabledTags: [Bool]
    var tags: [Tag]
    
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
                    
                    VStack(alignment: .leading) {
                        
                        
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
        CardMutationView(sideA: $a, sideB: $b, enabledTags: .constant([false, false, false]), tags: vm.tags)
    }
}
