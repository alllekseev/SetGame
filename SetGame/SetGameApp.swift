//
//  SetGameApp.swift
//  SetGame
//
//  Created by Олег Алексеев on 14.02.2024.
//

import SwiftUI

@main
struct SetGameApp: App {
  @StateObject var game = SetGameViewModel()
  var body: some Scene {
    WindowGroup {
      SetGameView(game: game)
    }
  }
}
