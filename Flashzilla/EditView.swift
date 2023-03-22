//
//  EditView.swift
//  Flashzilla
//
//  Created by Justin Hold on 11/18/22.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = DataManager.load()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Question", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCard)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
        }
    }
    func done() {
        dismiss()
    }
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        DataManager.save(cards)
        newPrompt = ""
        newAnswer = ""
    }
    func removeCard(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        DataManager.save(cards)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
