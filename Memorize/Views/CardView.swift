//
//  CardView.swift
//  Memorize
//
//  Created by Andrew Harrington on 4/22/23.
//

import SwiftUI

struct CardView: View {
    private var card: Card<String>
    var themeColor: Color
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                
                if !card.isMatched {
                    if card.isFaceUp {
                        shape.fill().foregroundColor(.white)
                        shape.strokeBorder(lineWidth: DrawingConstants.borderLineWidth)
                        Text(card.content).font(font(in: geometry.size))
                    } else {
                        shape.fill(themeColor)
                    }
                } else {
                    shape.fill(themeColor).opacity(0.0)
                }
            }
            .foregroundColor(themeColor)
        })
    }
    
    init(_ card: Card<String>, themeColor: Color) {
        self.card = card
        self.themeColor = themeColor
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let borderLineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(Card(id: 2, content: ""), themeColor: .red)
    }
}
