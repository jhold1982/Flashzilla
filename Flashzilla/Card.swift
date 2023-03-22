//
//  Card.swift
//  Flashzilla
//
//  Created by Justin Hold on 11/17/22.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    var id = UUID()
    let prompt: String
    let answer: String
    static let example = Card(prompt: "Who played Doctor Strange?", answer: "Benedict Cumberbatch")
}
