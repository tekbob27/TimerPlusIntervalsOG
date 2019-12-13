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
    var color: Color
    var displayValues: [Int]
    var index: Int
    var width: CGFloat
    
    var body: some View {
        Picker(selection: self.$time.interval.array[index], label: Text(self.label)) {
            ForEach(0 ..< self.displayValues.count) {
                Text(String(format: "%02d", self.displayValues[$0]))
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(maxWidth: width)
        .clipped()
        .border(color)
    }
}

struct TimePicker: View {
    @Binding var time: Tempus
    var labels: [String] = ["HH", "MM", "SS"]
    var displayValues: [[Int]] = [Array(0...24), Array(0...59), Array(0...59)]
    var colors: [Color] = [ Color.red, Color.blue, Color.green ]

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack(spacing: 0) {
                    ForEach(0 ..< self.labels.count) { index in
                        TimePickerView(time: self.$time,
                                       label: self.labels[index],
                                       color: self.colors[index],
                                       displayValues: self.displayValues[index],
                                       index: index,
                                       width: geometry.size.width / 4).environmentObject(self.time)
                    }
                }
            Text("\(self.$time.interval.array[0].wrappedValue):\(self.$time.interval.array[1].wrappedValue):\(self.$time.interval.array[2].wrappedValue)")
            }
        }
    }
}
