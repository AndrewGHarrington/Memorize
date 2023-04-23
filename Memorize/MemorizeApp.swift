//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Andrew Harrington on 4/16/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let emojiGame = EmojiGame()
    
    var body: some Scene {
        WindowGroup {
            MemorizeView(emojiGame: emojiGame)
        }
    }
}
