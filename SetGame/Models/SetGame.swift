//
//  SetGame.swift
//  SetGame
//
//  Created by Олег Алексеев on 14.02.2024.
//

import Foundation

struct SetGame {

  private(set) var cards = [Card]()
  private(set) var score = 0

  func getNewCards() {

  }

  func creatCards() -> [Card] {
    return cards
  }

  //FIXME: move enums in ViewModel or in View
  enum Shape {
    case diamond
    case capsule
    case rectangle
  }

  enum Shading {
    case transparent
    case solid
    case striped
  }

  struct Card: Hashable {
    let id = UUID()
    let shape: String
    let color: String
    let shading: String
    let itemsCount: Int

    var isTouched: Bool
    private var isMatched: Bool
  }
}
