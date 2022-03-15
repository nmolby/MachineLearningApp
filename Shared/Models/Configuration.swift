//
//  Configuration.swift
//  MachineLearning
//
//  Created by Nathan Molby on 3/4/22.
//

import Foundation

class Configuration: ObservableObject {
    @Published var trialLength: Int = 200
    @Published var gamma: Float = 0.99
    @Published var epsilon: Float = 0.99
    @Published var epsilon_min: Float = 0.01
    @Published var epsilon_decay: Float = 0.999
    @Published var neuralNetStructure: [Int] = [8, 64, 4]
    @Published var learningRate: Float = 0.1
    @Published var momentum: Float = 0.99
    
    init() {
        
    }
}
