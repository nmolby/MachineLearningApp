//
//  SnakeReinforcementLearning.swift
//  MachineLearningAdventures
//
//  Created by Nathan Molby on 2/22/22.
//

import Foundation

class SnakeReinforcementLearning: ObservableObject {
    @Published var agent: DQN
    
    init() {
        agent = DQN()
    }
    
    func Learn() {
        let env = SnakeEnvironment(gridHeight: 5, gridWidth: 5)
        let trials = 2000
        let trialLength = 250
        var rewards: [Float] = []

        for trial in 0..<trials {
            var currentState = env.reset()
            var trialReward: Float = 0
            for i in 0..<trialLength {
                let action = agent.act(state: currentState)
                let resultOfMoving = env.Move(direction: Direction(rawValue: action)!)
                trialReward += resultOfMoving.reward
                
                agent.remember(state: currentState, action: action, reward: resultOfMoving.reward, new_state: resultOfMoving.newState, done: resultOfMoving.done)
                if i % 5 == 0 {
                    agent.replay()
                }
                currentState = resultOfMoving.newState
                if resultOfMoving.done == 1 {
                    break
                }
            }
            rewards.append(trialReward)
            
            if trial % 10 == 0 {
                print("Trial \(trial)")
                print("Alpha: \(agent.epsilon)")
                if trial >= 10 {
                    print("Last 10 trial mean: \(rewards.reversed().prefix(upTo: 10).reduce(0.0, {return $0 + $1/Float(10)}))")
                }
                if trial >= 30 {
                    print("Last 30 trial mean: \(rewards.reversed().prefix(upTo: 30).reduce(0.0, {return $0 + $1/Float(30)}))")
                }
                if trial >= 50 {
                    var last50Mean = rewards.reversed().prefix(upTo: 50).reduce(0.0, {return $0 + $1/Float(50)})
                    if last50Mean > 5 {
                        return
                    }
                    print("Last 50 trial mean: \(last50Mean)")
                }
            }
            
        }
    }
}
