//
//  EditTimesForm.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 8/31/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI

struct EditTimesForm: View {
    @ObservedObject var timer: Timers
    @Environment(\.managedObjectContext) var managedObjectContext

    @State var updatedName: String = ""
    
    @State var data: [[Int64]] = [
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
        }.onDisappear() {
            try! self.timer.managedObjectContext?.save()
        }
    }
}

