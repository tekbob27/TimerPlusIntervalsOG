//
//  EditTimesForm.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 8/31/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI

struct EditTimesForm: View {
    @ObservedObject var timer: TimerEntity
    
    @State var updatedName: String = ""
    @State var updatedDurationHours: Int = 0
    @State var updatedDurationMinutes: Int = 25
    @State var updatedDurationSeconds: Int = 0
    @State var updatedIntervalHours: Int = 0
    @State var updatedIntervalMinutes: Int = 0
    @State var updatedIntervalSeconds: Int = 30
    
    @State var data: [[Int]] = [
        Array(0...24),
        Array(0...59),
        Array(0...59)
    ]
    @State var duration: [Int] = [0, 10, 0]
    @State var interval: [Int] = [0, 10, 0]
    
    @State var alarmSound = ""
    @State var alertSound = ""
    var soundData = SoundFileData()

    var body: some View {
        Form {
            Section(header: Text("Timer")) {
                Text("Name: \(timer.name!)")
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Alarm: \(timer.alarmSound!)")
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Alert: \(timer.alertSound!)")
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Section(header: Text("Timer Duration"),
                    footer:
                        Text("Duration: \(String(format: "%02d:%02d:%02d", self.duration[0], self.duration[1], self.duration[2]))")
                            ,
                    content: {
                        HStack {
                            VStack(alignment: .center, spacing: 0.0) {
                                HStack(alignment: .bottom, spacing: 0.0) {
                                    Spacer()
                                    Text("Hours")
                                    Spacer()
                                    Text("Minutes")
                                    Spacer()
                                    Text("Seconds")
                                    Spacer()
                                }
                                PickerControl(data: self.$data,
                                             selection: self.$duration)
                                .onAppear {
                                    self.duration = [self.updatedDurationHours, self.updatedDurationMinutes, self.updatedDurationSeconds]
                                }
                            }
                        }.frame(width: UIScreen.main.bounds.size.width, height: 225.0, alignment: .center)
            })
            Section(header: Text("Timer Interval"),
                    footer:
                        Text("Interval: \(String(format: "%02d:%02d:%02d", self.interval[0], self.interval[1], self.interval[2]))")
                            ,
                    content: {
                        HStack {
                            VStack(alignment: .center, spacing: 0.0) {
                                HStack(alignment: .bottom, spacing: 0.0) {
                                    Spacer()
                                    Text("Hours")
                                    Spacer()
                                    Text("Minutes")
                                    Spacer()
                                    Text("Seconds")
                                    Spacer()
                                }
                                PickerControl(data: self.$data,
                                              selection: self.$interval)
                                    .onAppear {
                                        self.interval = [self.updatedIntervalHours, self.updatedIntervalMinutes, self.updatedIntervalSeconds]
                                }
                            }
                        }.frame(width: UIScreen.main.bounds.size.width, height: 225.0, alignment: .center)
            })
        }
    }
}

