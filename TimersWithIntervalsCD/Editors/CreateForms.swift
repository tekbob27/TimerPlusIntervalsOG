//
//  EditForms.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/27/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI

struct NewTimerForm: View {
    @ObservedObject var timer: TempusBrevis
    
    var body: some View {
        Form {
            Section(header: Text("New")) {
                TextField("Name", text: self.$timer.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                NavigationLink(destination: NewTimesForm(timer: timer)) {
                    Text("New times").font(.headline).foregroundColor(.black)
                }
                NavigationLink(destination: NewSoundsForm(timer: timer)) {
                    Text("New sounds").font(.headline).foregroundColor(.black)
                }
            }
        }.frame(width: UIScreen.main.bounds.size.width, height: 225.0, alignment: .center)
    }
}

struct NewTimesForm: View {
    @ObservedObject var timer: TempusBrevis

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
                Text("Alarm: \(timer.toString("alarm"))")
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Alert: \(timer.toString("interrupt"))")
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Section(header: Text("Timer Duration: \(self.timer.toString("duration"))"),
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
                                TempusEligo(time: self.$timer.duration)
                            }
                        }.frame(width: UIScreen.main.bounds.size.width, height: 200.0, alignment: .center)
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
                                TempusEligo(time: self.$timer.interlude)
                            }
                        }.frame(width: UIScreen.main.bounds.size.width, height: 200.0, alignment: .center)
            })
        }
    }
}

struct NewSoundsForm: View {
    @ObservedObject var timer: TempusBrevis
    @Environment(\.managedObjectContext) var managedObjectContext

    @State var sounds: [[String]] = []

    var body: some View {
        Form {
            Section(header: Text("Timer")) {
                Text("Name: \(timer.name)")
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Section(header: Text("Alarm: \(self.timer.toString("alarm"))\t\tAlert: \(self.timer.toString("interrupt"))"),
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
