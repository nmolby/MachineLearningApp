//
//  GameState.swift
//  MachineLearning
//
//  Created by Nathan Molby on 1/8/22.
//

import Foundation

class GameState: ObservableObject {
    @Published var grid: Grid
    @Published var snake: Snake
    var direction: Direction = Direction.East
    
    init(gridWidth: Int, gridHeight: Int) {
        let grid = Grid(height: gridHeight, width: gridWidth)
        snake = Snake(grid: grid)
        self.grid = grid

    }
    
    func Move(direction: Direction) {
        snake.Move(direction: direction)
    }
    

}
