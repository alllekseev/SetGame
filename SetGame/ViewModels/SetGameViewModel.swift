//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Олег Алексеев on 15.02.2024.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
  
  @Published private var game: SetGame
  
  var cardCounter: Int {
    game.deck.count - game.cards.count
  }

  init() {
    game = SetGame()
  }

  var cards: [SetGame.Card] {
    return game.cards
  }

  var score: Int {
    return game.score
  }

  // MARK: - Intents

  func addCards() {
    game.addCards()
  }

  func choose(_ card: SetGame.Card) {
    game.choose(card)
  }

  func createNewGame() {
    game = SetGame()
  }
}
