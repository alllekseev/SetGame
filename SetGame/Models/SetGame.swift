//
//  SetGame.swift
//  SetGame
//
//  Created by Олег Алексеев on 14.02.2024.
//

import Foundation

struct SetGame {

  private var cards: [Card]
  private(set) var openedCards: [Card]
  private(set) var score: Int

  init() {
    cards = []
    openedCards = []
    score = 0
    createCards { cards in
      self.cards = cards
    }
    cards.shuffle()
    openedCards = getCards(12)
    cards.removeLast(12)
  }

  private func createCards(complition: ([Card]) -> Void) {
    var cards = [Card]()
    for shape in Shape.allCases {
      for color in Color.allCases {
        for shading in Shading.allCases {
          for itemsCount in ItemsCount.allCases {
            cards.append(
              Card(
                shapeView: Card.ShapeView(
                  shape: shape,
                  color: color,
                  shading: shading
                ),
                itemsCount: itemsCount
              )
            )
          }
        }
      }
    }
    complition(cards)
    cards.removeAll()
  }

  mutating func addCards(){
    openedCards.append(contentsOf: getCards(3))
    cards.removeLast(3)
  }

  private var cardsInSet = [Card]()
  mutating func choose(_ card: Card) {
    guard let index = openedCards.firstIndex(where: { $0.id == card.id }) else {
      return
    }
    openedCards[index].highlighted.toggle()
    if !cardsInSet.contains(where: { $0.id == card.id }) {
      cardsInSet.append(card)
      if cardsInSet.count == 3 {
        score = checkSet() ? score + 1 : score
        cardsInSet.removeAll()
      }
      return
    } else {
      if let currentIndex = cardsInSet.firstIndex(where: { $0.id == card.id }) {
        cardsInSet.remove(at: currentIndex)
      }
    }
  }

  private mutating func checkSet() -> Bool {
    defer {
      for card in cardsInSet {
        if let index = openedCards.firstIndex(where: { $0.id == card.id }) {
          openedCards[index].highlighted.toggle()
        }
      }
    }
    return (cards[0] == cards[1] && cards[1] == cards[2] && cards[2] == cards[0]) || (cards[0] != cards[1] && cards[1] != cards[2] && cards[2] != cards[0])
  }

  private func getCards(_ amount: Int) -> [Card] {
    let suffix = cards.suffix(from: cards.endIndex - amount)
    return Array(suffix)
  }

  struct Card: Hashable, Identifiable {
    let id = UUID()
    let shapeView: ShapeView
    let itemsCount: ItemsCount

    var highlighted = false
    var isMatched = false

    struct ShapeView: Hashable {
      let shape: Shape
      let color: Color
      let shading: Shading
    }

    static func == (lhs: Card, rhs: Card) -> Bool {
      var res: Bool
      let shape = lhs.shapeView.shape == rhs.shapeView.shape || lhs.shapeView.shape != rhs.shapeView.shape
      let color = lhs.shapeView.color == rhs.shapeView.color || lhs.shapeView.color != rhs.shapeView.color
      let shading = lhs.shapeView.shading == rhs.shapeView.shading || lhs.shapeView.shading != rhs.shapeView.shading
      let number = lhs.itemsCount == rhs.itemsCount && lhs.itemsCount != rhs.itemsCount
      res = shape && color && shading || shape && color && number || shape && shading && number || color && shading && number
      return res
    }
  }
}

extension SetGame {
  enum Shape: CaseIterable {
    case capsule, rectangle, diamond
  }

  enum Color: CaseIterable {
    case red, green, blue
  }

  enum Shading: CaseIterable {
    case fill, streak, stroke
  }

  enum ItemsCount: Int, CaseIterable {
    case one = 1, two, three
  }
}

extension SetGame.Card: CustomDebugStringConvertible {
  var debugDescription: String {

    let description = """
      id: \(id), shape: \(shapeView.shape),
      color: \(shapeView.color),
      shading: \(shapeView.shading),
      itemsCount: \(itemsCount),
      highlighted: \(highlighted ? "true" : ""),
      isMatched: \(isMatched ? "true" : "")
    """

    return description
  }
}
