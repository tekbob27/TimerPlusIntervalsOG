//
//  PickerControl.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 8/30/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI

//let formatter = NumberFormatter()
//
extension String.StringInterpolation {
    mutating func appendInterpolation(_ number: Int, style: NumberFormatter.Style = .none) {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 2
        formatter.numberStyle = style

        if let result = formatter.string(from: number as NSNumber) {
            appendLiteral(result)
        }
    }
}

struct PickerControl<Data>: UIViewRepresentable where Data: Equatable {
    @Binding var data: [[Data]]
    @Binding var selection: [Data]

    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {

        @Binding var data: [[Data]]
        @Binding var selection: [Data]

        init(data: Binding<[[Data]]>, selection: Binding<[Data]>) {
            self._data = data
            self._selection = selection
        }

    
        func pickerView(_ pickerView: UIPickerView,
                        numberOfRowsInComponent component: Int) -> Int {
            data[component].count
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            data.count
        }

        func pickerView(_ pickerView: UIPickerView,
                        widthForComponent component: Int) -> CGFloat {
            (pickerView.superview?.bounds.width ?? 0) / CGFloat(data.count)
        }

        func pickerView(_ pickerView: UIPickerView,
                        rowHeightForComponent component: Int) -> CGFloat {
            30.0
        }

        func pickerView(_ pickerView: UIPickerView,
                        viewForRow row: Int,
                        forComponent component: Int,
                        reusing view: UIView?) -> UIView {

            guard let reusableView = view as? UILabel else {
                let label = UILabel(frame: .zero)
                label.backgroundColor = UIColor.red.withAlphaComponent(0.15)
                label.text = "\(data[component][row])"
//                if data[component][row] is Int64 {
//                    label.text = String(format: "%02d", Int("\(data[component][row])")!)
//                } else if data[component][row] is String {
//                    label.text = String(format: "%@", "\(data[component][row])")
//                }
                label.textAlignment = .center
                return label
            }
            
            reusableView.text = "\(data[component][row])"
//            if data[component][row] is Int64 {
//                reusableView.text = String(format: "%02d", Int("\(data[component][row])")!)
//            } else if data[component][row] is String {
//                reusableView.text = String(format: "%@", "\(data[component][row])")
//            }
            reusableView.textAlignment = .center
            return reusableView
        }

        func pickerView(_ pickerView: UIPickerView,
                        didSelectRow row: Int,
                        inComponent component: Int) {
            let value = data[component][row]
            selection[component] = value
        }
    }

    func makeCoordinator() -> PickerControl.Coordinator {
        return Coordinator(data: $data,
                           selection: $selection)
    }

    func makeUIView(context: UIViewRepresentableContext<PickerControl>) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIView(_ uiView: UIPickerView,
                      context: UIViewRepresentableContext<PickerControl>) {

        uiView.reloadAllComponents()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.selection.enumerated().forEach { tuple in
                let (offset, value) = tuple
                let row = self.data[offset].firstIndex { $0 == value } ?? 0
                uiView.selectRow(row, inComponent: offset, animated: false)
            }
        }
    }
}
