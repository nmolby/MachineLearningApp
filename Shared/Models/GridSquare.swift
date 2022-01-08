//
//  GridSquare.swift
//  MachineLearning
//
//  Created by Nathan Molby on 1/8/22.
//

import Foundation

class GridSquare: ObservableObject, Identifiable {
    var index: Int
    @Published var snakeNode: SnakeNode?
    @Published var hasTreat: Bool
    var row: GridRow
    var id = UUID()
    
    init(index: Int, row: GridRow) {
        self.index = index
        self.row = row
        hasTreat = false
    }
}
