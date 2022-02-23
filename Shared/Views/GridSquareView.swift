//
//  GridSquareView.swift
//  MachineLearning
//
//  Created by Nathan Molby on 1/8/22.
//

import SwiftUI

struct GridSquareView: View {
    @EnvironmentObject var snake: SnakeEnvironment
    var location: (x: Int, y: Int)
    
    var body: some View {
        if snake.snake.count > 0 && snake.snake[0] == location {
            Image(systemName: "square.fill")
                .foregroundColor(Color.red)
        }
        else if snake.snake.count > 0 && snake.snake.contains(where: {$0 == location}) {
            Image(systemName: "square.fill")
        } else if snake.treatLocation == location {
            Image(systemName: "square.fill")
                .foregroundColor(Color.green)
        } else {
            Image(systemName: "square")

        }
    }
}
