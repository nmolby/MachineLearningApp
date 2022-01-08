//
//  Snake.swift
//  MachineLearning
//
//  Created by Nathan Molby on 1/8/22.
//

import Foundation

class Snake {
    var grid: Grid
    var tailSnakeNode: SnakeNode
    
    init(grid: Grid) {
        self.grid = grid
        let targetGridSquare = grid.gridRows[grid.height / 2].gridSquares[grid.width / 2]
        
        tailSnakeNode = SnakeNode(gridSquare: targetGridSquare, parentNode: nil)
        targetGridSquare.snakeNode = tailSnakeNode
        tailSnakeNode.snake = self
    }
    
    func Move(direction: Direction) {
        tailSnakeNode.Move(direction: direction)
    }
    
    func Lose() {
        
    }
    
    func FindNextSquare(gridSquare: GridSquare, direction: Direction) -> GridSquare? {
        switch(direction) {
        case Direction.North:
            if(gridSquare.row.index == 0) {
                return nil
            } else {
                return grid.gridRows[gridSquare.row.index - 1].gridSquares[gridSquare.index]
            }
        case Direction.South:
            if(gridSquare.row.index == grid.height - 1) {
                return nil
            } else {
                return grid.gridRows[gridSquare.row.index + 1].gridSquares[gridSquare.index]
            }
        case Direction.East:
            if(gridSquare.index == grid.width - 1) {
                return nil
            } else {
                return grid.gridRows[gridSquare.row.index].gridSquares[gridSquare.index + 1]
            }
        case Direction.West:
            if(gridSquare.index == 0) {
                return nil
            } else {
                return grid.gridRows[gridSquare.row.index].gridSquares[gridSquare.index - 1]
            }
        }
    }
}
