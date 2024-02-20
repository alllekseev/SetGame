//
//  CardView.swift
//  SetGame
//
//  Created by Олег Алексеев on 15.02.2024.
//

import SwiftUI

struct CardView: View {
   let cardContent: SetGame.Card

  init(_ cardContent: SetGame.Card) {
    self.cardContent = cardContent
  }

  var body: some View {
    ZStack {
      let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
      Group {
        base.strokeBorder(lineWidth: Constants.lineWidth)
          .background(base.fill(.white))
        VStack {
          ForEach(1...cardContent.itemsCount.rawValue, id: \.self) { _ in
            ShapeView(shapeConfigure: cardContent.shapeView)
          }
        }.padding(Constants.inset)
      }
    }
    .scaleEffect(cardContent.highlighted ? Constants.ScaleEffect.smallest : Constants.ScaleEffect.largest)
  }

  private struct Constants {
    static let cornerRadius: CGFloat = 12
    static let inset: CGFloat = 6
    static let lineWidth: CGFloat = 2
    static let vStackInset: CGFloat = 0

    struct ScaleEffect {
      static let largest: CGFloat = 1
      static let smallest: CGFloat = 0.9
    }
  }
}

#Preview {
  CardView(
    SetGame.Card(
      shapeView: .init(
        shape: .diamond,
        color: .red,
        shading: .stroke
      ),
      itemsCount: .two
    )
  )
}
