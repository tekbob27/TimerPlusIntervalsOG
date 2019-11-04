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
    @Environment(\.managedObjectContext) var managedObjectContext

    @State var updatedName: String = ""
    
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
                        Text("Duration: \(getDurationString())")
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
                            }
                        }.frame(width: UIScreen.main.bounds.size.width, height: 225.0, alignment: .center)
            })
            Section(header: Text("Timer Interval"),
                    footer:
                        Text("Interval: \(getIntervalString())")
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
                            }
                        }.frame(width: UIScreen.main.bounds.size.width, height: 225.0, alignment: .center)
            })
        }.onAppear() {
            self.duration[0] = Int(self.timer.duration?.hours ?? 0)
            self.duration[1] = Int(self.timer.duration?.minutes ?? 0)
            self.duration[2] = Int(self.timer.duration?.seconds ?? 0)
            self.interval[0] = Int(self.timer.interval?.hours ?? 0)
            self.interval[1] = Int(self.timer.interval?.minutes ?? 0)
            self.interval[2] = Int(self.timer.interval?.seconds ?? 0)
        }.onDisappear() {
            try! self.timer.managedObjectContext?.save()
        }
    }
    
    func getDurationString() -> String {
        let duration = String(format: "%02d:%02d:%02d", self.duration[0], self.duration[1], self.duration[2])
        if self.timer.duration == nil {
            DurationEntity.newDurationFromInput(duration, context: managedObjectContext).addToTimer(timer)
        } else {
            self.timer.duration?.hours = Int64(self.duration[0])
            self.timer.duration?.minutes = Int64(self.duration[1])
            self.timer.duration?.seconds = Int64(self.duration[2])
        }
        return duration
    }

    func getIntervalString() -> String {
        let interval = String(format: "%02d:%02d:%02d", self.interval[0], self.interval[1], self.interval[2])
        if self.timer.interval == nil {
            IntervalEntity.newIntervalFromInput(interval, context: managedObjectContext).addToTimer(timer)
        } else {
            self.timer.interval?.hours = Int64(self.duration[0])
            self.timer.interval?.minutes = Int64(self.duration[1])
            self.timer.interval?.seconds = Int64(self.duration[2])
        }

        return interval
    }
}

