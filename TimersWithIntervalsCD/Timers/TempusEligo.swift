//
//  TimePicker.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/28/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI
import Combine

struct TempusEligo: View {
    @Binding var time: Tempus
    var hours: [Int] = Array(0...24)
    var minutes: [Int] = Array(0...59)
    var seconds: [Int] = Array(0...59)
        
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Picker(selection: self.$time.hh, label: Text("Hours")) {
                    ForEach(0 ..< self.hours.count) {
                        Text(String(format: "%02d", self.hours[$0]))
                    }
                }
                .frame(maxWidth: geometry.size.width / 4)
                .clipped()
                .border(Color.red)
                .pickerStyle(WheelPickerStyle())
                
                Picker(selection: self.$time.mm, label: Text("Minutes")) {
                    ForEach(0 ..< self.minutes.count) {
                        Text(String(format: "%02d", self.minutes[$0]))
                    }
                }
                .frame(maxWidth: geometry.size.width / 4)
                .clipped()
                .border(Color.blue)
                .pickerStyle(WheelPickerStyle())

                Picker(selection: self.$time.ss, label: Text("Seconds")) {
                    ForEach(0 ..< self.seconds.count) {
                        Text(String(format: "%02d", self.seconds[$0]))
                    }
                }
                .frame(maxWidth: geometry.size.width / 4)
                .clipped()
                .border(Color.green)
                .pickerStyle(WheelPickerStyle())
            }
        }
    }
}
