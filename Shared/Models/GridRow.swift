//
//  GridRow.swift
//  MachineLearning
//
//  Created by Nathan Molby on 1/8/22.
//

import Foundation

class GridRow: ObservableObject, Identifiable {
    @Published var gridSquares: [GridSquare] = []
    
    var index: Int
    var width: Int
    var id = UUID()
    
    init(width: Int, index: Int) {
        self.width = width
        self.index = index
        for i in 0..<width {
            gridSquares.append(GridSquare(index: i, row: self))
        }
    }
    
}
