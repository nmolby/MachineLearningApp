//
//  Grid.swift
//  MachineLearning
//
//  Created by Nathan Molby on 1/8/22.
//

import Foundation

class Grid: ObservableObject {
    var height: Int
    var width: Int
    
    @Published var gridRows: [GridRow]
    
    init(height: Int, width: Int) {
        self.height = height
        self.width = width
        gridRows = []
        
        for i in 0..<height {
            gridRows.append(GridRow(width: width, index: i))
        }
    }
}
