//
//  ContentView.swift
//  TestEditMode
//
//  Created by Bob O'Connor on 11/26/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI

struct TimePickerView: View {
    @Binding var time: Tempus
    var label: String
    var displayValues: [Int]
    var index: Int
    var width: CGFloat
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(self.label)
            Picker("Picker", selection: self.$time.interval.array[index]) {
                ForEach(0 ..< self.displayValues.count) {
                    Text(String(format: "%02d", self.displayValues[$0]))
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(maxWidth: width)
            .clipped()
            .border(Color.black)
        }
    }
}

struct TimePicker: View {
    @Binding var time: Tempus
    var labels: [String] = ["HH", "MM", "SS"]
    var displayValues: [[Int]] = [Array(0...24), Array(0...59), Array(0...59)]

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 5) {
                HStack(spacing: 0) {
                    ForEach(0 ..< self.labels.count) { index in
                        TimePickerView(time: self.$time,
                                       label: self.labels[index],
                                       displayValues: self.displayValues[index],
                                       index: index,
                                       width: (geometry.size.width * 0.9) / CGFloat(self.displayValues.count) + 0.5)
                    }
                }.frame(minWidth: geometry.size.width * 0.95, idealWidth: geometry.size.width * 0.95, maxWidth: geometry.size.width * 0.95, alignment: .center)
            }
        }
    }
}
