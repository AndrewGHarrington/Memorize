//
//  MemoryGame.swift
//  Memorize
//
//  Created by Andrew Harrington on 4/17/23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card<CardContent>]
    private(set) var score = 0
    private var addToScoreAmount = 2
    private var subtractFromScoreAmount = 1
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }
        }
    }
    
    mutating func choose(card: Card<CardContent>) {
        // TODO: Update code like in lesson 5
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if indexOfOneAndOnlyFaceUpCard == nil {
                // no cards flipped over right now
                indexOfOneAndOnlyFaceUpCard = chosenIndex
                
                // turn over card just selected
                cards[chosenIndex].hasBeenSeen = true
            } else {
                // at least one card has been flipped over
                // make sure the currently selected card is not a card that that was just flipped before this one
                
                if !(cards[indexOfOneAndOnlyFaceUpCard!].id == card.id) {
                    // check for a match
                    if cards[indexOfOneAndOnlyFaceUpCard!].content == cards[chosenIndex].content {
                        cards[indexOfOneAndOnlyFaceUpCard!].isMatched = true
                        cards[chosenIndex].isMatched = true
                        
                        score += addToScoreAmount
                    } else {
                        if cards[indexOfOneAndOnlyFaceUpCard!].hasBeenSeen && cards[chosenIndex].hasBeenSeen {
                            score -= subtractFromScoreAmount
                        }
                    }
                    
                    cards[chosenIndex].isFaceUp = true
                    cards[chosenIndex].hasBeenSeen = true
                }
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createContent: (Int) -> CardContent) {
        cards = [Card]()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            cards.append(Card(id: pairIndex * 2, content: createContent(pairIndex)))
            cards.append(Card(id: pairIndex * 2 + 1, content: createContent(pairIndex)))
        }
        
        cards.shuffle()
    }
}

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
