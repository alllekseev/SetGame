//
//  CustomButtonStyle.swift
//  SetGame
//
//  Created by Олег Алексеев on 19.02.2024.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
  var foreground: Color
  var background: Color

  init(foreground: Color, background: Color) {
    self.foreground = foreground
    self.background = background
  }

  func makeBody(configuration: Configuration) -> some View {
    CustomButton(foreground: foreground, background: background, configuration: configuration)
  }


  struct CustomButton: View {

    var foreground: Color
    var background: Color
    let configuration: ButtonStyle.Configuration

    @Environment (\.isEnabled) private var isEnabled: Bool

    var body: some View {
      configuration.label
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .font(.title2)
        .foregroundStyle(isEnabled ? foreground : foreground.opacity(0.5))
        .background(isEnabled ? background : background.opacity(0.5))
        .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
  }

}
