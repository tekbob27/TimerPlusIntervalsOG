//
//  EditForms.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/27/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI

struct EditTimerForm: View {
    @ObservedObject var timer: Timers
    
    var body: some View {
        Form {
            Section(header: Text("Timer")) {
                TextField("Name", text: self.$timer.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                NavigationLink(destination: EditTimesForm(timer: timer)) {
                    Text("Edit times").font(.headline).foregroundColor(.black)
                }
                NavigationLink(destination: EditSoundsForm(timer: timer)) {
                    Text("Edit sounds").font(.headline).foregroundColor(.black)
                }
            }
        }
    }
}

struct EditTimesForm: View {
    @ObservedObject var timer: Timers
    
    @State var data: [[Int]] = [
        Array(0...24),
        Array(0...59),
        Array(0...59)
    ]
    
    var soundData = SoundFileData()

    var body: some View {
        Form {
            Section(header: Text("Timer")) {
                Text("Name: \(timer.name)")
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Alarm: \(timer.duration.sound)")
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Alert: \(timer.interlude.sound)")
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Section(header: Text("Timer Duration: \(self.timer.duration.toString())"),
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
                                              selection: self.$timer.dComponents)
                            }
                        }.frame(width: UIScreen.main.bounds.size.width, height: 225.0, alignment: .center)
            })
            Section(header: Text("Timer Interval: \(self.timer.interlude.toString())"),
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
                                              selection: self.$timer.iComponents)
                            }
                        }.frame(width: UIScreen.main.bounds.size.width, height: 225.0, alignment: .center)
            })
        }
    }
}

struct EditSoundsForm: View {
    @ObservedObject var timer: Timers
    @Environment(\.managedObjectContext) var managedObjectContext

    @State var sounds: [[String]] = []

    var body: some View {
        Form {
            Section(header: Text("Timer")) {
                Text("Name: \(timer.name)")
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Section(header: Text("Alarm: \(self.timer.duration.sound)\t\tAlert: \(self.timer.interlude.sound)"),
                    content: {
                        HStack(alignment: .center, spacing: 0) {
                            VStack(alignment: .center, spacing: 0) {
                                HStack(alignment: .top, spacing: 0.0) {
                                    Spacer()
                                    Text("Alarms")
                                    Spacer()
                                    Text("Alerts")
                                    Spacer()
                                }
                                PickerControl(data: $sounds,
                                              selection: self.$timer.sounds)
                            }
                        }.frame(width: UIScreen.main.bounds.size.width, height: 225.0, alignment: .center)
            })
        }.onAppear() {
            if self.sounds.count == 0 {
                self.sounds.append(SoundFileData.Alarms)
                self.sounds.append(SoundFileData.Alerts)
            }
        }
    }
}
