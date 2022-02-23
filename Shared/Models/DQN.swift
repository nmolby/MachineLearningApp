//
//  DQN.swift
//  MachineLearningAdventures
//
//  Created by Nathan Molby on 2/22/22.
//

import Foundation


class DQN: ObservableObject {
    var memory: Array<(originalState: Array<Float>, action: Int, reward: Float, newState: Array<Float>, done: Int)> = []
    var gamma: Float = 0.99
    var epsilon: Float = 0.99
    var epsilon_min: Float = 0.01
    var epsilon_decay: Float = 0.999
    @Published public var model: NeuralNet

    init() {
        self.memory = []

        self.gamma = 0.95
        self.epsilon = 0.99
        self.epsilon_min = 0.005
        self.epsilon_decay = 0.995
        
        let structure = try! NeuralNet.Structure(nodes: [8, 16, 4], hiddenActivation: .rectifiedLinear, outputActivation: .softmax, learningRate: 0.001, momentum: 0.99)

        self.model = try! NeuralNet(structure: structure)
    }

    func act(state: Array<Float>) -> Int {
        self.epsilon *= self.epsilon_decay
        self.epsilon = max(self.epsilon_min, self.epsilon)
        if Float.random(in: 0..<1) < self.epsilon {
            return Int.random(in: 0..<4)
        }
        let prediction = try! self.model.infer(state)
        let max = prediction.enumerated().max(by: { (a, b) in
            a.element < b.element
        })
        return max!.offset
    }


    func remember(state: [Float], action: Int, reward: Float, new_state: [Float], done: Int) {
        if memory.count > 1000 {
            memory.removeSubrange(0..<100)
        }
        self.memory.append((state, action, reward, new_state, done))
    }

    func replay() {
        let batch_size = 8
        if self.memory.count < batch_size {
            return
        }

        let samples = self.memory.shuffled().prefix(upTo: batch_size)
        for sample in samples {
            var target = try! self.model.infer(sample.originalState)
            if sample.done == 1 {
                target[sample.action] = sample.reward
            }
            else {
                let Q_future = try! self.model.infer(sample.newState).max()!
                target[sample.action] = sample.reward + Q_future * self.gamma
            }

            try! self.model.infer(sample.originalState)
            try! self.model.backpropagate(target)
        }
        

    }
}
