//
//  ContentView.swift
//  FirstProject
//
//  Created by Ollie Quarm on 27/2/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView(isFaceUp: false)
        }
        .foregroundColor(.orange)
        .imageScale(.small)
        .padding()
    }
}


struct CardView: View {
    @State var isFaceUp: Bool = false
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text("✅").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }

        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}


#Preview {
    ContentView()
}
