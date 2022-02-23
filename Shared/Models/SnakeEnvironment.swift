//
//  Snake.swift
//  MachineLearning
//
//  Created by Nathan Molby on 1/8/22.
//

import Foundation

class SnakeEnvironment: ObservableObject {
    var gridHeight: Int
    var gridWidth: Int
    @Published var snake: [(x: Int, y: Int)] = []
    @Published var treatLocation: (x: Int, y: Int) = (0, 0)
    
    init(gridHeight: Int, gridWidth: Int) {
        self.gridHeight = gridHeight
        self.gridWidth = gridWidth
        
        let targetGridSquare = (gridWidth / 2, gridHeight / 2)
        snake.append(targetGridSquare)
        SetTreatLocation()
    }
    
    func reset() -> Array<Float> {
        self.snake = [(gridWidth / 2, gridHeight / 2)]
        self.SetTreatLocation()
        return self.getState()
    }
    
    func getState() -> Array<Float> {
        var state = Array(repeating: Float(0), count: 8)
        let head = self.snake[0]
        if self.treatLocation.y < head.y { //treat NORTH
            state[0] = 1
        }
        if self.treatLocation.x > head.x { //treat EAST
            state[1] = 1
        }
        if self.treatLocation.y > head.y { //treat SOUTH
            state[2] = 1
        }
        if self.treatLocation.x < head.x { //treat WEST
            state[3] = 1
        }
        if head.y == 0 || self.snake.contains(where: {$0 == (head.x, head.y - 1)}) { //DANGER NORTH
            state[4] = 1
        }
        if head.x == gridWidth - 1 || self.snake.contains(where: {$0 == (head.x + 1, head.y)}) { //DANGER EAST
            state[5] = 1
        }
        if head.y == gridHeight - 1 || self.snake.contains(where: {$0 == (head.x, head.y + 1)}) { //DANGER SOUTH
            state[6] = 1
        }
        if head.x == 0 || self.snake.contains(where: {$0 == (head.x - 1, head.y )}) { //DANGER WEST
            state[7] = 1
        }
        
        return state
    }
    
    func SetTreatLocation() {
        var treatX = Int.random(in: 0..<gridWidth)
        var treatY = Int.random(in: 0..<gridHeight)
        treatLocation = (treatX, treatY)
        
        while snake.contains(where: {$0 == treatLocation}) {
            treatX = Int.random(in: 0..<gridWidth)
            treatY = Int.random(in: 0..<gridHeight)
            treatLocation = (treatX, treatY)
        }
    }
    
    func Move(direction: Direction) -> (newState: [Float], reward: Float, done: Int) {
        let head = snake[0]
        var newNode: (x: Int, y: Int)
        
        switch(direction) {
        case .North:
            newNode = (head.x, head.y - 1)
        case .East:
            newNode = (head.x + 1, head.y)
        case .South:
            newNode = (head.x, head.y + 1)
        case .West:
            newNode = (head.x - 1, head.y)
        }
        
        if newNode != treatLocation {
            snake.removeLast()
        }
        var reward: Float = 0
        var done = 0
        //if the snake will enter an illegal position
        if newNode.y < 0 || newNode.y >= gridHeight || newNode.x < 0 || newNode.x >= gridWidth || snake.contains(where: {$0 == newNode}) {
            reward = -2
            done = 1
        }
        snake.insert(newNode, at: 0)
        
        if newNode == treatLocation {
            reward = 1
            SetTreatLocation()
        }
        
        return (getState(), reward, done)
    }
}
