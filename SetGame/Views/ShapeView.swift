//
//  ShapeView.swift
//  SetGame
//
//  Created by Олег Алексеев on 15.02.2024.
//

import SwiftUI

struct ShapeView: View {
  let shapeConfigure: SetGame.Card.ShapeView
  var shape: AnyShape

  private var shapeColor: Color {
    switch shapeConfigure.color {
    case .red: return Color.red
    case .green: return Color.green
    case .blue: return Color.blue
    }
  }

  private var shapeShading: Double {
    switch shapeConfigure.shading {
    case .fill: return 1.0
    case .streak: return 0.4
    case .stroke: return 0.0
    }
  }

  init(shapeConfigure: SetGame.Card.ShapeView) {
    self.shapeConfigure = shapeConfigure
    self.shape = AnyShape(Rectangle())
    self.shape = createShape(shapeConfigure.shape)
  }

  var body: some View {
    shape
      .stroke(
        shapeColor,
        style: StrokeStyle(
          lineWidth: 6,
          lineCap: .round,
          lineJoin: .round
        )
      )
      .fill(shapeColor.opacity(shapeShading))
      .scaleEffect(0.6)
      .aspectRatio(2/1, contentMode: .fit)
  }
}

extension ShapeView {
  private func createShape(_ setGameShape: SetGame.Shape) -> AnyShape {
    var shape: AnyShape

    switch setGameShape {
    case .capsule:
      shape = AnyShape(Capsule())
    case .rectangle:
      shape = AnyShape(Rectangle())
    case .diamond:
      shape = AnyShape(Diamond())
    }

    return shape
  }
}

#Preview {
  ShapeView(
    shapeConfigure: SetGame.Card.ShapeView(
      shape: .diamond,
      color: .blue,
      shading: .streak
    )
  )
}
