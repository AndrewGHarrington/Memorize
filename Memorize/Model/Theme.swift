//
//  Theme.swift
//  Memorize
//
//  Created by Andrew Harrington on 4/18/23.
//

import Foundation

class Theme<CardContent> {
    let name: String
    let numberOfPairsOfCards: Int
    let content: [CardContent]
    let color: String
    
    init(name: String, numberOfPairsOfCards: Int, content: [CardContent], color: String) {
        self.name = name
        self.numberOfPairsOfCards = numberOfPairsOfCards
        self.content = content
        self.color = color
    }
}
