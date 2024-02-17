//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Олег Алексеев on 15.02.2024.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
  
  @Published private var game: SetGame

  init() {
    game = SetGame()
  }

  var cards: [SetGame.Card] {
    return game.openedCards
  }

  var score: Int {
    return game.score
  }

  // MARK: - Intents

  func addCards() {
    game.addCards()
  }

  func choose(_ card: SetGame.Card, withIndex index: Int) {
    game.choose(card, withIndex: index)
  }
}
