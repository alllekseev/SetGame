//
//  SetGameView.swift
//  SetGame
//
//  Created by Олег Алексеев on 14.02.2024.
//

import SwiftUI

struct SetGameView: View {
  @ObservedObject var game: SetGameViewModel

  var body: some View {
    VStack {
      header
        .padding(.bottom, 20)
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 95), spacing: 0)], spacing: 0) {
          ForEach(Array(zip(game.cards.indices, game.cards)), id: \.0) { (index, card) in
            CardView(cardContent: card)
              .aspectRatio(2/3, contentMode: .fit)
              .onTapGesture {
                game.choose(card, withIndex: index)
              }
          }
          .padding(4)
        }
      }
      Spacer()
      bottom
    }
    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
  }

  private var header: some View {
    HStack {
      Text("Set Game")
        .font(.title)
      Spacer()
      Text("15")
        .font(.title)
        .fontWeight(.bold)
    }
  }

  private var bottom: some View {
    VStack(spacing: 20) {
      Button("Deal New Cards") {

      }
      .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
      .font(.title2)
      .background(.indigo)
      .foregroundStyle(.white)
      .clipShape(Capsule())
      Button("New Game") {

      }
      .font(.title3)
    }
    .fontWeight(.medium)
  }
}

//#Preview {
//  SetGameView(game: SetGameViewModel())
//}
