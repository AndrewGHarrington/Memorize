//
//  EmojiGame.swift
//  Memorize
//
//  Created by Andrew Harrington on 4/17/23.
//

import Foundation

class EmojiGame: ObservableObject {
    // card content
    private let vehicleEmojis: [String]
    private let deviceEmojis: [String]
    private let foodEmojis: [String]
    private let smileysEmojis: [String]
    private let animalEmojis: [String]
    private let sportsEmojis: [String]
    
    // themes
    private let vehicleTheme: Theme<String>
    private let deviceTheme: Theme<String>
    private let foodTheme: Theme<String>
    private let smileysTheme: Theme<String>
    private let animalsTheme: Theme<String>
    private let sportsTheme: Theme<String>
    
    private(set) var selectedTheme: Theme<String>
    
    // instance of the Model
    @Published private var model: MemoryGame<String>
    
    // collection of card objects from model
    var cards: [Card<String>] {
        model.cards
    }
    
    init() {
        // initialize all of the emoji sets for the different themes
        vehicleEmojis = ["🚔", "🚝", "✈️", "🚂", "🚀", "🚃", "🛩️", "⛴️", "🛳️", "⛵️", "🚤", "🚗"]
        deviceEmojis = ["⌚️", "📱", "💻", "🖱️", "🖥️", "📷", "🎙️", "📺"]
        foodEmojis = ["🍙", "🍜", "🍛", "🍩", "🍘", "🍥", "🍣", "🍡", "🍮", "🍬"]
        smileysEmojis = ["😀", "🥹", "😂", "☺️", "🥰", "🥳", "😎", "😟", "😡", "😱", "🤬", "🤢"]
        animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐸"]
        sportsEmojis = ["⚽️", "🏀", "⚾️", "🏐", "🎾"]
        
        // initialize Themes
        vehicleTheme = Theme<String>(name: "Vehicles",
                                     numberOfPairsOfCards: 12,
                                     content: vehicleEmojis.shuffled(),
                                     color: "red")
        deviceTheme = Theme<String>(name: "Devices",
                                    numberOfPairsOfCards: 8,
                                    content: deviceEmojis.shuffled(),
                                    color: "gray")
        foodTheme = Theme<String>(name: "Food",
                                  numberOfPairsOfCards: 10,
                                  content: foodEmojis.shuffled(),
                                  color: "green")
        smileysTheme = Theme<String>(name: "Smileys",
                                     numberOfPairsOfCards: 6,
                                     content: smileysEmojis.shuffled(),
                                     color: "yellow")
        animalsTheme = Theme<String>(name: "Animals",
                                     numberOfPairsOfCards: 12,
                                     content: animalEmojis.shuffled(),
                                     color: "orange")
        sportsTheme = Theme<String>(name: "Sports",
                                    numberOfPairsOfCards: 5,
                                    content: sportsEmojis,
                                    color: "blue")
        
        // initialize the random theme
        selectedTheme = EmojiGame.chooseRandomTheme(from: [vehicleTheme,
                                                           deviceTheme,
                                                           foodTheme,
                                                           smileysTheme,
                                                           animalsTheme,
                                                           sportsTheme])
        
        // initialize model
        model = EmojiGame.createModel(with: selectedTheme)
    }
    
    
    static func chooseRandomTheme(from themeCollection: [Theme<String>]) -> Theme<String> {
        let randomIndex = Int.random(in: themeCollection.indices)
        
        return themeCollection[randomIndex]
    }
    
    static func createModel(with theme: Theme<String>) -> MemoryGame<String> {
        var safeNumPairOfCards = theme.numberOfPairsOfCards
        
        // makes sure there are enough emojis to build the suggested numberOfPairsOfCards.
        // if there isn't, it will default to the count of the emojis for that theme
        if theme.numberOfPairsOfCards > theme.content.count {
            safeNumPairOfCards = theme.content.count
        }
        
        return MemoryGame<String>(numberOfPairsOfCards: safeNumPairOfCards) { pairIndex in
            theme.content[pairIndex]
        }
    }
    
    
    // MARK: - Intents
    func choose(theme: String) {
        switch theme {
        case "vehicle":
            selectedTheme = vehicleTheme
        case "device":
            selectedTheme = deviceTheme
        case "food":
            selectedTheme = foodTheme
        case "smiley":
            selectedTheme = smileysTheme
        case "animal":
            selectedTheme = animalsTheme
        case "sports":
            selectedTheme = sportsTheme
        default:
            selectedTheme = vehicleTheme
        }
        
        model = EmojiGame.createModel(with: selectedTheme)
    }
    
    func choose(card: Card<String>) {
        model.choose(card: card)
    }
    
    func createNewGame() {
        selectedTheme = EmojiGame.chooseRandomTheme(from: [vehicleTheme,
                                                           deviceTheme,
                                                           foodTheme,
                                                           smileysTheme,
                                                           animalsTheme,
                                                           sportsTheme])
        
        model = EmojiGame.createModel(with: selectedTheme)
    }
    
    func updateScore() -> Int {
        model.score
    }
}
