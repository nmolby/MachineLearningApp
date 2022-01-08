//
//  GridSquareView.swift
//  MachineLearning
//
//  Created by Nathan Molby on 1/8/22.
//

import SwiftUI

struct GridSquareView: View {
    @ObservedObject var gridSquare: GridSquare
    
    var body: some View {
        if gridSquare.snakeNode != nil {
            Image(systemName: "square.fill")
        } else if gridSquare.hasTreat {
            Image(systemName: "square.fill")
                .foregroundColor(Color.green)
        } else {
            Image(systemName: "square")

        }
    }
}
