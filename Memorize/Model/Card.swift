//
//  Card.swift
//  Memorize
//
//  Created by Andrew Harrington on 4/18/23.
//

import Foundation

struct Card<CardContent>: Identifiable {
    private(set) var id: Int
    var isFaceUp = false
    var isMatched = false
    var hasBeenSeen = false
    let content: CardContent
}
