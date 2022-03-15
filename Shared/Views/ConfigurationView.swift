//
//  ConfigurationView.swift
//  MachineLearning
//
//  Created by Nathan Molby on 3/4/22.
//

import SwiftUI

struct ConfigurationView: View {
    @ObservedObject var configuration: Configuration
    
    var body: some View {
        Form() {
            Section(header: Text("Model Parameters")) {
                GenericTextField(inputBinding: self.$configuration.gamma, description: "Gamma", errorContent: { Text("Enter a number") }, conversion: {(myString) in return Float(myString)})
                GenericTextField(inputBinding: self.$configuration.epsilon, description: "Epsilon", errorContent: { Text("Enter a number") }, conversion: {(myString) in return Float(myString)})
                GenericTextField(inputBinding: self.$configuration.epsilon_min, description: "Epsilon Min", errorContent: { Text("Enter a number") }, conversion: {(myString) in return Float(myString)})
                GenericTextField(inputBinding: self.$configuration.epsilon_decay, description: "Epsilon Decay", errorContent: { Text("Enter a number") }, conversion: {(myString) in return Float(myString)})
                GenericTextField(inputBinding: self.$configuration.learningRate, description: "Learning Rate", errorContent: { Text("Enter a number") }, conversion: {(myString) in return Float(myString)})
                GenericTextField(inputBinding: self.$configuration.momentum, description: "Momentum", errorContent: { Text("Enter a number") }, conversion: {(myString) in return Float(myString)})
            }
            Section(header: Text("Trial Information")) {
                GenericTextField(inputBinding: self.$configuration.trialLength, description: "Trial Length", errorContent: { Text("Enter a number") }, conversion: {(myString) in return Int(myString)})
            }
  

   
        }
    }
}
