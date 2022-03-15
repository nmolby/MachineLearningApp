//
//  SnakeReinforcementLearning.swift
//  MachineLearningAdventures
//
//  Created by Nathan Molby on 2/22/22.
//

import Foundation

class SnakeReinforcementLearning: ObservableObject {
    @Published var agent: DQN
    @Published var trial: Int = 0
    var rewards: [Double] = []
    
    init(configuration: Configuration) {
        agent = DQN(configuration: configuration)
    }
    
    func Learn(trials: Int, callback: ([Double]) -> ()) {
        let env = SnakeEnvironment(gridHeight: 5, gridWidth: 5)
        let trialLength = 250

        for i in 0..<trials {
            trial = i
            var currentState = env.reset()
            var trialReward: Double = 0
            for i in 0..<trialLength {
                let action = agent.act(state: currentState)
                let resultOfMoving = env.Move(direction: Direction(rawValue: action)!)
                trialReward += Double(resultOfMoving.reward)
                
                agent.remember(state: currentState, action: action, reward: resultOfMoving.reward, new_state: resultOfMoving.newState, done: resultOfMoving.done)
                if i % 3 == 0 {
                    agent.replay()
                }
                currentState = resultOfMoving.newState
                if resultOfMoving.done == 1 {
                    break
                }
            }
            rewards.append(trialReward)
            
            callback(rewards)

            
        }
    }
}
