// ViewModel. Talks to the model to express intents.

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    // static makes emojis global, but namespace it inside my class. Globals initialized first. Won't pollute the namespace outside the class.
    private static let emojis = ["🧑🏽‍🦳", "✅", "😇", "😄", "🤪", "😎", "😅"]
    
    // Private as we don't want anyone else creating a game for us.
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 7) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "Oops"
            }
        }
    }
    
    // Create memory game that is of strings. If this var changes, we note the change.
    // Private means view can't see it, but that doesn't it can't cause something to change?
    @Published private var model = createMemoryGame()

    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    // Gate keeping mode...
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}

//func createCardContent(forPairAtIndex index: Int) -> String {
//    return ["hey", "✅", "😇", "😄", "🤪", "😎", "😅"][index]
//}

//cardContentFactory: { ( index: Int) -> String in
//    return ["hey", "✅", "😇", "😄", "🤪", "😎", "😅"][index]
//}
