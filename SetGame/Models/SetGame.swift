//
//  SetGame.swift
//  SetGame
//
//  Created by Олег Алексеев on 14.02.2024.
//

import Foundation

struct SetGame {

  private(set) var deck: [Card]
  private(set) var cards: [Card]
  private(set) var score: Int

  private var cardsAmountInDeck: Int = 12

  init() {
    deck = []
    cards = []
    score = 0
    createCards { cards in
      self.deck = cards
    }
    cards = getCards(cardsAmountInDeck)
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

    #if DEBUG
      cards = Array(cards[0...11])
    #else
      cards.shuffle()
    #endif

    complition(cards)
    cards.removeAll()
  }

  private mutating func checkSet() -> Bool {
    var result = false

    defer {
      for card in cardsInSet {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
          if result {
            if cards.count > cardsAmountInDeck {
              cards.remove(at: index)
            } else {
              if let card = getCards(1).first {
                cards[index] = card
              } else {
                cards.remove(at: index)
              }
            }
          } else {
            cards[index].highlighted.toggle()
          }
        }
      }
      cardsInSet.removeAll()
    }

    var shape = Set<Shape>()
    var color = Set<Color>()
    var shading = Set<Shading>()
    var number = Set<ItemsCount>()

    for card in cardsInSet {
      shape.insert(card.shapeView.shape)
      color.insert(card.shapeView.color)
      shading.insert(card.shapeView.shading)
      number.insert(card.itemsCount)
    }

    if shape.count == 2 || color.count == 2 || shading.count == 2 || number.count == 2 {
      return result
    }
    result = true

    return result
  }

  private mutating func getCards(_ amount: Int) -> [Card] {
    guard deck.count >= amount else {
      return []
    }
    let suffix = deck.suffix(from: deck.endIndex - amount)
    deck.removeLast(amount)
    return Array(suffix)
  }

  // MARK: - Intents

  mutating func addCards(){
    cards.append(contentsOf: getCards(3))
  }

  private var cardsInSet = [Card]()

  mutating func choose(_ card: Card) {
    guard let index = cards.firstIndex(where: { $0.id == card.id }) else {
      return
    }

    cards[index].highlighted.toggle()
    
    if !cardsInSet.contains(where: { $0.id == card.id }) {
      cardsInSet.append(card)
      if cardsInSet.count == 3 {
        score = checkSet() ? score + 1 : score
      }
      return
    } else {
      if let currentIndex = cardsInSet.firstIndex(where: { $0.id == card.id }) {
        cardsInSet.remove(at: currentIndex)
      }
    }
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
