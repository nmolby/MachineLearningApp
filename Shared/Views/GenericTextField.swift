//
//  FloatTextField.swift
//  MachineLearning
//
//  Created by Nathan Molby on 3/4/22.
//

import SwiftUI

struct GenericTextField<Content: View, ConversionType: CustomStringConvertible>: View {
    @Binding var inputBinding: ConversionType
    @State var inputString: String
    let conversion: (String)  -> ConversionType?
    let description: String
    let errorContent: Content
    
    @State var errorMessageShown: Bool = false
    var colorOfDescriptioon: Color {
        if($inputString.wrappedValue.isEmpty) {
            return Color(.placeholderText)
        } else if (self.errorMessageShown) {
            return Color.red
        } else {
            return Color.accentColor
        }
    }
    init(inputBinding: Binding<ConversionType>, description: String, @ViewBuilder errorContent: () -> Content, conversion: @escaping (String) -> ConversionType?) {
        self.errorContent = errorContent()
        self._inputBinding = inputBinding
        self.conversion = conversion
        self.description = description
        self._inputString = State(initialValue: inputBinding.wrappedValue.description)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(description)
                .foregroundColor(colorOfDescriptioon)
                .offset(y: $inputString.wrappedValue.isEmpty ? 0 : -25)
                .scaleEffect($inputString.wrappedValue.isEmpty ? 1 : 0.75, anchor: .leading)
            TextField("", text: $inputString)
                .keyboardType(.decimalPad)
                .onChange(of: inputString) { (newValue) in
                        if let convertedValue = self.conversion(newValue) {
                            inputBinding = convertedValue
                            self.errorMessageShown = false
                        } else {
                            self.errorMessageShown = true
                        }
                    }
        }
        .padding(.top, 15)
        .animation(.spring(response: 0.3, dampingFraction: 0.5))
    }
}
