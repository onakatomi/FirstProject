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
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            // We filter the array for face up items, we take the only one out of there
            return cards.indices.filter { index in cards[index].isFaceUp }.only
            // return faceUpCardIndicies.count == 1 ? faceUpCardIndicies.first : nil
        }
        set {
            // Sets all cards to be face down except for the one you set the new value for
            cards.indices.forEach{ cards[$0].isFaceUp = (newValue == $0) }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { cardToCheck in
            cardToCheck.id == card.id
        }) {
            print(card)
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
        // Do nothing if the index isn't found.
    }
    
    // Need this keyword so that we know we're doing copy on write -- I hope that's what you intend!
    mutating func shuffle() {
        cards.shuffle()
    }
    
    // Nested struct -- good for namespacing
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up:" : "down") \(isMatched ? "matched" : "not matched")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
