//
//  AspectVGrid.swift
//  FirstProject
//
//  Created by Ollie Quarm on 28/2/2024.
//

import SwiftUI

// Lays out any array of things
struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView // Pass in item you want me to make a view for. Don't need @ViewBuilder here as init says it
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
                // ForEach can now tell which cards go with which views. Moves view to its new place in the array
                ForEach(items) { item in
                    // Want a view for each item. Content takes an item and returns a view for it.
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    // Calculate the size of the cards such that we don't have to scroll -- fit in the space available to us.
    func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            // Get width & height of cells based on columns we have
            let width = size.width / columnCount
            let height = width/aspectRatio
            
            let rowCount  = (count/columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        
        // If we've exhausted all options.
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}
