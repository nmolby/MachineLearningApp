//
//  SnakeView.swift
//  MachineLearning
//
//  Created by Nathan Molby on 1/8/22.
//

import SwiftUI

struct GridView: View {
    @ObservedObject var grid: Grid
    
    var body: some View {
        VStack {
            ForEach(grid.gridRows) { gridRow in
                HStack {
                    ForEach(gridRow.gridSquares) { gridSquare in
                        GridSquareView(gridSquare: gridSquare)
                    }
                }
            }
        }
    }
}
