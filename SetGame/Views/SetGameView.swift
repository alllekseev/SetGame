//
//  SetGameView.swift
//  SetGame
//
//  Created by Олег Алексеев on 14.02.2024.
//

import SwiftUI

struct SetGameView: View {
  var body: some View {
    VStack {
      header
        .padding(.bottom, 20)
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 95), spacing: 0)], spacing: 0) {
          ForEach((1...3), id: \.self) { _ in
            CardView()
              .padding(4)
              .aspectRatio(2/3, contentMode: .fit)
          }
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
      HStack {
        Text("Finded Sets:")
          .font(.title2)
        Text("15")
          .font(.title)
          .fontWeight(.bold)
      }
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

#Preview {
  SetGameView()
}
