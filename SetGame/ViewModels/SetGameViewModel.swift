//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Олег Алексеев on 15.02.2024.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
  
  @Published private var game: SetGame
  var cardCounter: Int

  init() {
    cardCounter = 0
    game = SetGame()
    cardCounter = 81 - game.cards.count
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
    cardCounter -= 3
  }

  func choose(_ card: SetGame.Card) {
    game.choose(card)
  }

  func createNewGame() {
    cardCounter = 0
    game = SetGame()
    cardCounter = 81 - game.cards.count
  }
}
