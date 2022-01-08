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
    
    func Move(direction: Direction) -> Bool {
        if(gridSquare.snakeNode === self) {
            gridSquare.snakeNode = nil
        }
        
        if(isStartOfSnake) {
            let nextSquare = snake?.FindNextSquare(gridSquare: gridSquare, direction: direction)
            if let nextSquare = nextSquare {
                gridSquare = nextSquare
                gridSquare.snakeNode = self
                let treatFound = nextSquare.hasTreat
                nextSquare.hasTreat = false
                return treatFound
            } else {
                snake!.Lose()
                return false
            }
        }
        else {

            gridSquare = parentNode!.gridSquare
            gridSquare.snakeNode = self
            return parentNode!.Move(direction: direction)
        }
    }
    
    
}
