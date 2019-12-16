//
//  PickerControl.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 8/30/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI

public var data: [[Int64]] = [
    Array(0...24),
    Array(0...59),
    Array(0...59)
]

struct IntervalPickerControl<Interval>: UIViewRepresentable where Interval: AbstractInterval {
    @Binding var selection: Interval
    public var selectedRows: [String] = []

    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {

        @Binding var selection: Interval
        private var selectedRows: [String] = []
        
        init(selection: Binding<Interval>, selectedRows: [String]) {
            self._selection = selection
            self.selectedRows = selectedRows
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
                label.text = String(format: "%02d", Int("\(data[component][row])")!)
                label.textAlignment = .center
                return label
            }
            
            reusableView.text = String(format: "%02d", Int("\(data[component][row])")!)
            reusableView.textAlignment = .center
            return reusableView
        }

        func pickerView(_ pickerView: UIPickerView,
                        didSelectRow row: Int,
                        inComponent component: Int) {
            let value = data[component][row]
            selectedRows[component] = "\(value)"
            $selection.wrappedValue.duration = AbstractInterval.fromTime(timeArray: selectedRows)
        }
    }

    func makeCoordinator() -> IntervalPickerControl.Coordinator {
        return Coordinator(selection: $selection)
    }

    func makeUIView(context: UIViewRepresentableContext<IntervalPickerControl>) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIView(_ uiView: UIPickerView,
                      context: UIViewRepresentableContext<IntervalPickerControl>) {

        uiView.reloadAllComponents()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.selectedRows.enumerated().forEach { tuple in
                let (offset, value) = tuple
                let intVal = Int64(value) ?? 0
                let row = data[offset].firstIndex { $0 == intVal } ?? 0
                uiView.selectRow(row, inComponent: offset, animated: false)
            }
        }
    }
}
