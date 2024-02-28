// Model

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card> // Access control.
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // Add number of pairs of cards times 2
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = index(of: card) {
            cards[chosenIndex].isFaceUp.toggle()
        }
        // Do nothing if the index isn't found.
    }
    
    func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    // Need this keyword so that we know we're doing copy on write -- I hope that's what you intend!
    mutating func shuffle() {
        cards.shuffle()
    }
    
    // Nested struct -- good for namespacing
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up:" : "down") \(isMatched ? "matched" : "not matched")"
        }
    }
}
