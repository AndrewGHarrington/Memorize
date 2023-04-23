//
//  ContentView.swift
//  Memorize
//
//  Created by Andrew Harrington on 4/16/23.
//

import SwiftUI

struct MemorizeView: View {
    @ObservedObject var emojiGame: EmojiGame
    
    var body: some View {
        VStack {
            HStack {
                Text(emojiGame.selectedTheme.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button("New Game") {
                    emojiGame.createNewGame()
                }
            }
            Spacer()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojiGame.cards) { card in
                        CardView(card, themeColor: convertColor())
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                emojiGame.choose(card: card)
                            }
                    }
                }
            }
            Spacer()
            Text("Score: \(emojiGame.updateScore())")
                .font(.title )
            Spacer()
            HStack {
                Group {
                    Button {
                        emojiGame.choose(theme: "vehicle")
                    } label: {
                        VStack {
                            Image(systemName: "airplane")
                                .font(.title)
                            Text("Vehicles")
                                .font(.subheadline)
                        }
                    }
                    Spacer()
                    Button {
                        emojiGame.choose(theme: "device")
                    } label: {
                        VStack {
                            Image(systemName: "display")
                                .font(.title)
                            Text("Devices")
                                .font(.subheadline)
                        }
                    }
                    Spacer()
                    Button {
                        emojiGame.choose(theme: "food")
                    } label: {
                        VStack {
                            Image(systemName: "cart")
                                .font(.title)
                            Text("Food")
                                .font(.subheadline)
                        }
                    }
                }
                Spacer()
                Group {
                    Button {
                        emojiGame.choose(theme: "smiley")
                    } label: {
                        VStack {
                            Image(systemName: "face.smiling.inverse")
                                .font(.title)
                            Text("Smileys")
                                .font(.subheadline)
                        }
                    }
                    Spacer()
                    Button {
                        emojiGame.choose(theme: "animal")
                    } label: {
                        VStack {
                            Image(systemName: "pawprint.circle.fill")
                                .font(.title)
                            Text("Animals")
                                .font(.subheadline)
                        }
                    }
                    Spacer()
                    Button {
                        emojiGame.choose(theme: "sports")
                    } label: {
                        VStack {
                            Image(systemName: "figure.highintensity.intervaltraining")
                                .font(.title)
                            Text("Sports")
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    func convertColor() -> Color {
        var themeColor: Color?
        
        switch emojiGame.selectedTheme.color {
        case "red":
            themeColor = .red
        case "gray":
            themeColor = .gray
        case "green":
            themeColor = .green
        case "yellow":
            themeColor = .yellow
        case "orange":
            themeColor = .orange
        case "blue":
            themeColor = .blue
        default:
            themeColor = .red
        }
        
        return themeColor!
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemorizeView(emojiGame: EmojiGame())
    }
}
