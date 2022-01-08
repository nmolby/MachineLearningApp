//
//  ControlView.swift
//  MachineLearning
//
//  Created by Nathan Molby on 1/8/22.
//

import SwiftUI

struct ControlView: View {
    @Binding var direction: Direction
    
    var body: some View {
        HStack {
            Button("Left") {
                direction = Direction.West
            }
            Button("Right") {
                direction = Direction.East
            }
            Button("Up") {
                direction = Direction.North
            }
            Button("Down") {
                direction = Direction.South
            }
        }

    }
}
