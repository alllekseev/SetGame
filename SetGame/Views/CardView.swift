//
//  CardView.swift
//  SetGame
//
//  Created by Олег Алексеев on 15.02.2024.
//

import SwiftUI

struct CardView: View {
  let base = RoundedRectangle(cornerRadius: 25, style: .circular)
  let shape = ShapeView(shape: Capsule(), color: .cyan)
  let shapesAmount = 2

  var body: some View {
    ZStack {
      base
        .fill(.white)
        .strokeBorder(lineWidth: 3)
      // TODO: use here theme color
        .foregroundStyle(.green)
      VStack(spacing: 0) {
        ForEach(1...shapesAmount, id: \.self) { _ in
          shape
        }
      }
    }
  }
}

#Preview {
  CardView()
}
