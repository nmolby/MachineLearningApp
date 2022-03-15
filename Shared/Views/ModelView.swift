//
//  ModelView.swift
//  MachineLearning
//
//  Created by Nathan Molby on 3/5/22.
//

import SwiftUI

struct ModelView: View {
    @Binding var snakeReinforcementlearning: SnakeReinforcementLearning!
    @State var trialSimulations: Int = 50
    @StateObject var snake = SnakeEnvironment(gridHeight: 5, gridWidth: 5)
    @State var timer: Timer?
    @State var snakeEnvironmentResults: [Double] = []
    @State private var reinforementLearningJob: DispatchWorkItem?
    
    var body: some View {
        VStack {
            if let _ = timer { //if the job is not running
                GridView(height: 5, width: 5)
            } else {
                LineChartSwiftUI(entries: snakeEnvironmentResults)
            }
            Text(snakeReinforcementlearning.trial.description)
            GenericTextField(inputBinding: $trialSimulations, description: "Trials to Simulate", errorContent: { Text("Enter an int")}, conversion: { Int($0) })
            Button("Simulate trials") {
                self.timer?.invalidate()
                self.timer = nil
                //TODO: do this on a background thread
                self.reinforementLearningJob = DispatchWorkItem {
                    snakeReinforcementlearning.Learn(trials: trialSimulations) { (rewards) in
                        DispatchQueue.main.async {
                            snakeEnvironmentResults = rewards
                        }
                    }
                    DispatchQueue.main.async {
                        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: self.executeSnakeMove)
                    }
                }
                
                DispatchQueue.global().async(execute: reinforementLearningJob!)
            }
        }
        .onAppear() {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: self.executeSnakeMove)
        }
        .environmentObject(snake)

        
    }
    
    func executeSnakeMove(_: Timer) {
        let recommendedMove = snakeReinforcementlearning.agent.act(state: snake.getState())

        let done = snake.Move(direction: Direction(rawValue: recommendedMove)!).done
        if done != 0 {
            snake.reset()
        }
    }
}
