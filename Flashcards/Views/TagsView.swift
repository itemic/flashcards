//
//  TagsView.swift
//  Flashcards
//
//  Created by Terran Kroft on 7/18/20.
//

import SwiftUI

struct TagsView: View {
    @ObservedObject var vm = FlashcardsVM()
    var body: some View {
        VStack {
            Text("All Tags")
            ForEach(vm.tags) { tag in
                Text("TAG: \(tag.name)")
            }
        }.navigationTitle("Tags")
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView()
    }
}
