//
//  SnakeView.swift
//  MachineLearning
//
//  Created by Nathan Molby on 1/8/22.
//

import SwiftUI

struct GridView: View {
    var height: Int
    var width: Int
    
    var body: some View {
        VStack {
            ForEach(0..<height) { y in
                HStack {
                    ForEach(0..<width) { x in
                        GridSquareView(location: (x, y))
                    }
                }
            }
        }
    }
}
