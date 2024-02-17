//
//  CardView.swift
//  SetGame
//
//  Created by Олег Алексеев on 15.02.2024.
//

import SwiftUI

struct CardView: View {
   let base = RoundedRectangle(cornerRadius: 25, style: .circular)
   let cardContent: SetGame.Card

  init(cardContent: SetGame.Card) {
    self.cardContent = cardContent
  }


  var body: some View {
    ZStack {
      base
        .fill(.white)
        .strokeBorder(lineWidth: 3)
      // TODO: use here theme color
        .foregroundStyle(.green)
        .scaleEffect(cardContent.highlighted ? 0.4 : 1)
      VStack(spacing: 0) {
        ForEach(1...cardContent.itemsCount.rawValue, id: \.self) { _ in
          ShapeView(shapeConfigure: cardContent.shapeView)
        }
      }
    }
  }
}

#Preview {
  CardView(
    cardContent: SetGame.Card(
      shapeView: .init(
        shape: .diamond,
        color: .red,
        shading: .stroke
      ),
      itemsCount: .two
    )
  )
}
