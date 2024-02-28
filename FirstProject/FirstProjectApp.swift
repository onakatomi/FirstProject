//
//  FirstProjectApp.swift
//  FirstProject
//
//  Created by Ollie Quarm on 27/2/2024.
//

// yep

import SwiftUI

@main
struct FirstProjectApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
