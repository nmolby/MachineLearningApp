//
//  LineChartSwiftui.swift
//  Testing
//
//  Created by Nathan Molby on 3/15/22.
//

import Foundation
import SwiftUI
import Charts

struct LineChartSwiftUI: UIViewRepresentable {
    let entries: [Double]
    func makeUIView(context: Context) -> LineChartView {
        return LineChartView()
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        var finalEntries: [ChartDataEntry] = []
        for (index, entry) in entries.enumerated() {
            finalEntries.append(ChartDataEntry(x: Double(index), y: entry))
        }
        let dataSet = LineChartDataSet(entries: finalEntries)
        uiView.data = LineChartData(dataSet: dataSet)
    }
}


struct LineChartSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        LineChartSwiftUI(entries: [4, 5, 6])
    }
}
