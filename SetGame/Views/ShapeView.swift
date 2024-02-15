//
//  ShapeView.swift
//  SetGame
//
//  Created by Олег Алексеев on 15.02.2024.
//

import SwiftUI

struct ShapeView: View {
  var shape: AnyShape
  var color: Color

  init(shape: some Shape, color: Color) {
    self.shape = AnyShape(shape)
    self.color = color
  }

  var body: some View {
    shape
      .stroke(
        color,
        style: StrokeStyle(
          lineWidth: 6
        )
      )
      .fill(color.opacity(0.4))
      .scaleEffect(0.6)
      .aspectRatio(2/1, contentMode: .fit)
  }
}

#Preview {
  ShapeView(shape: Diamond(), color: .indigo)
}
