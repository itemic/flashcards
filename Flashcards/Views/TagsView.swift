//
//  TagsView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/18/20.
//

import SwiftUI

struct TagsView: View {
    @EnvironmentObject var vm: FlashcardsVM
    @State var showAddTagsPopover: Bool = false
    @State var newTagsTextField: String = ""
    var body: some View {
        
        List {
            Section(header: Text("All Tags")) {
            ForEach(vm.tags) { tag in
                NavigationLink(destination: LibraryView(filterTag: tag).environmentObject(vm)) {
                    Label("\(tag.name)", systemImage: "tag.fill")
                        

                }
            }.onDelete(perform: delete)
            }
            

            
            
        }.toolbar {
            
            ToolbarItem(placement: .automatic) {
                
                EditButton()
            }
            ToolbarItem(placement: .automatic) {
                
                Button(action: {
                    showAddTagsPopover.toggle()
                }, label: {
                    Text("Add Tag")
                    
                    
                }).popover(isPresented: $showAddTagsPopover, content: {
                    NavigationView {
                        ScrollView {
                            VStack(alignment: .leading) {
                                Text("Add multiple tags at once by separating them using commas.").font(.caption).foregroundColor(.secondary)
                                AutoFocusTextField(text: $newTagsTextField)
                                Spacer()
                            }.navigationTitle("Add Tags").navigationBarTitleDisplayMode(.inline)
                            .padding()
                            .frame(width: 300) // todo: if tags are long then stretch
                            .toolbar {
                                ToolbarItem(placement: .automatic) {
                                    Button("Cancel") {
                                        showAddTagsPopover.toggle()
                                        newTagsTextField = ""
                                    }
                                }
                                ToolbarItem(placement: .automatic) {
                                    Button("Add") {
                                        addTags()
                                        newTagsTextField = "" // empty the list
                                        showAddTagsPopover.toggle()
                                    }.disabled(newTagsTextField.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty )
                                }
                        }
                        }
                    }.frame(width: 300,height: 300)
                    
                })
            }
            
        }
        .navigationTitle("Tags").navigationBarTitleDisplayMode(.inline)
        .listStyle(InsetGroupedListStyle())
    }
    func addTags() {
        let individualTags = newTagsTextField.split(separator: ",", omittingEmptySubsequences: true)
        for tag in individualTags {
            let clearedTag = tag.trimmingCharacters(in: .whitespacesAndNewlines)
            if !clearedTag.isEmpty {
                vm.addTag(tag: Tag(name: clearedTag))
            }
        }
    }
    func delete(at offsets: IndexSet) {
        // delete tags from words
        for card in vm.words {
            for i in offsets {
                if card.tags.contains(vm.tags[i]) {
                    card.tags.remove(at: i)
                }
            }
        }
        
        vm.tags.remove(atOffsets: offsets)
        
        vm.objectWillChange.send()
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView()
    }
}

// adapted from https://stackoverflow.com/questions/56507839/swiftui-how-to-make-textfield-become-first-responder
struct AutoFocusTextField: UIViewRepresentable {
    @Binding var text: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<AutoFocusTextField>) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context:
        UIViewRepresentableContext<AutoFocusTextField>) {
        uiView.text = text
        uiView.placeholder = "Add tags"
        uiView.font = UIFont.preferredFont(forTextStyle: .title1)
        if uiView.window != nil, !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        }
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: AutoFocusTextField

        init(_ autoFocusTextField: AutoFocusTextField) {
            self.parent = autoFocusTextField
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}
