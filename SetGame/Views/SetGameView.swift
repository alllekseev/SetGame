//
//  SetGameView.swift
//  SetGame
//
//  Created by Олег Алексеев on 14.02.2024.
//

import SwiftUI

struct SetGameView: View {
  @ObservedObject var game: SetGameViewModel

  let configureation = ButtonStyleConfiguration.self

  private let cardsAspectRatio: CGFloat = 2/3
  private let spacing: CGFloat = 4

  var body: some View {
    VStack {
      header
        .padding(.bottom, 20)
      cards
        .foregroundStyle(.green)
        .animation(.default, value: game.cards)
      Spacer()
      bottom
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 8)
  }

  private var header: some View {
    HStack {
      Text("Set Game")
        .font(.title)
      Spacer()
      Text("\(game.score)")
        .font(.title)
        .fontWeight(.bold)
    }
  }

  private var cards: some View {
    AspectVGrid(game.cards, aspectRatio: cardsAspectRatio) { card in
      CardView(card)
        .padding(spacing)
        .onTapGesture {
          game.choose(card)
        }
    }
  }

  private var bottom: some View {
    VStack(spacing: 20) {
      Button("Deal New Cards") {
        game.addCards()
      }
      .clipShape(Capsule())
      .disabled(game.leftCardsInDeck)
      .buttonStyle(CustomButtonStyle(foreground: .white, background: .indigo))
      Button("New Game") {
        game.createNewGame()
      }
      .font(.title3)
    }
    .fontWeight(.medium)
  }

}

extension View {
  @ViewBuilder
  func wrappedInScrollView(when condition: Bool) -> some View {
    if condition {
      ScrollView {
        self
      }
    } else {
      self
    }
  }
}

#Preview {
  SetGameView(game: SetGameViewModel())
}
