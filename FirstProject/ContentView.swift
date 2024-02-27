//
//  ContentView.swift
//  FirstProject
//
//  Created by Ollie Quarm on 27/2/2024.
//

import SwiftUI

struct ContentView: View {
    let contents: Array<String> = ["hey", "✅", "😇", "😄", "🤪", "😎", "😅"]
    @State var cardCount = 2
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .imageScale(.small)
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(isFaceUp: true, content: contents[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > contents.count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

// Cards are a really important component, so we give it its own struct/view.
struct CardView: View {
    @State var isFaceUp: Bool = true
    let content: String
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)

        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}


#Preview {
    ContentView()
}
