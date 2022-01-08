//
//  SnakeNode.swift
//  MachineLearning
//
//  Created by Nathan Molby on 1/8/22.
//

import Foundation

class SnakeNode {
    var parentNode: SnakeNode?
    var gridSquare: GridSquare
    var snake: Snake?
    
    var isStartOfSnake: Bool {
        return parentNode == nil
    }
    
    init(gridSquare: GridSquare, parentNode: SnakeNode?) {
        self.parentNode = parentNode
        self.gridSquare = gridSquare
    }
    
    func Move(direction: Direction) {
        if(gridSquare.snakeNode === self) {
            gridSquare.snakeNode = nil
        }
        
        if(isStartOfSnake) {
            var nextSquare = snake?.FindNextSquare(gridSquare: gridSquare, direction: direction)
            if let nextSquare = nextSquare {
                gridSquare = nextSquare
                gridSquare.snakeNode = self
            } else {
                snake!.Lose()
            }
        }
        else {

            gridSquare = parentNode!.gridSquare
            gridSquare.snakeNode = self
            parentNode!.Move(direction: direction)
        }
    }
    
    
}
