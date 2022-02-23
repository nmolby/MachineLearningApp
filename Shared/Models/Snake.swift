//
//  Snake.swift
//  MachineLearning
//
//  Created by Nathan Molby on 1/8/22.
//

import Foundation

class Snake: ObservableObject {
    var gridHeight: Int
    var gridWidth: Int
    @Published var snake: [(x: Int, y: Int)] = []
    @Published var done: Bool = false
    @Published var treatLocation: (x: Int, y: Int) = (0, 0)
    
    init(gridHeight: Int, gridWidth: Int) {
        self.gridHeight = gridHeight
        self.gridWidth = gridWidth
        
        let targetGridSquare = (gridWidth / 2, gridHeight / 2)
        snake.append(targetGridSquare)
        SetTreatLocation()
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
    
    func Move(direction: Direction) {
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
        //if the snake will enter an illegal position
        if newNode.y < 0 || newNode.y >= gridHeight || newNode.x < 0 || newNode.x >= gridWidth || snake.contains(where: {$0 == newNode}) {
            Lose()
        }
        snake.insert(newNode, at: 0)
        
        if newNode == treatLocation {
            SetTreatLocation()
        }
    }
    
    func Lose() {
        done = true
    }
}
