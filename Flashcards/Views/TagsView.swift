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
                    newTagsTextField = ""
                    showAddTagsPopover.toggle()
                }, label: {
                    Text("Add Tag")
                    
                    
                }).popover(isPresented: $showAddTagsPopover, content: {
                    AddTagsPopoverView(textField: $newTagsTextField, showAddTagsPopover: $showAddTagsPopover).environmentObject(vm)
                    
                })
            }
            
        }
        .navigationTitle("Tags").navigationBarTitleDisplayMode(.inline)
        .listStyle(InsetGroupedListStyle())
    }
    
    func delete(at offsets: IndexSet) {
        // delete tags from words
        for card in vm.cards {
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

struct AddTagsPopoverView: View {
    @EnvironmentObject var vm: FlashcardsVM
    @Binding var textField: String
    @Binding var showAddTagsPopover: Bool
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Add multiple tags at once by separating them using commas.").font(.caption).foregroundColor(.secondary)
                    AutoFocusTextField(text: $textField)
                    Spacer()
                }.navigationTitle("Add Tags").navigationBarTitleDisplayMode(.inline)
                .padding()
                .frame(width: 300) // todo: if tags are long then stretch
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button("Cancel") {
                            showAddTagsPopover.toggle()
                        }
                    }
                    ToolbarItem(placement: .automatic) {
                        Button("Add") {
                            addTags()
                            textField = "" // empty the list
                            showAddTagsPopover.toggle()
                        }.disabled(textField.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty )
                    }
                }
            }
        }.frame(width: 300,height: 300)
    }
    
    func addTags() {
        let individualTags = textField.split(separator: ",", omittingEmptySubsequences: true)
        for tag in individualTags {
            let clearedTag = tag.trimmingCharacters(in: .whitespacesAndNewlines)
            if !clearedTag.isEmpty {
                vm.addTag(tag: Tag(name: clearedTag))
            }
            
        }
        vm.objectWillChange.send()
        
    }
}
