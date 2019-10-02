//
//  EditSoundsForm.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 8/31/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI

struct EditSoundsForm: View {
    @ObservedObject var timer: TimerEntity
    var alarms = [[String]]()
    var alerts = [[String]]()

    @State var alarmSound = ""
    @State var alertSound = ""
    var soundData = SoundFileData()

    var body: some View {
        Form {
            Section(header: Text("Timer")) {
                Text("Name: \(timer.name!)")
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Section(header: Text("Sounds")) {
                Picker(selection: $timer.alarmSound, label: Text("Alarms")) {
                    ForEach(0 ..< soundData.alarms.count) {
                        Text(self.soundData.alarms[$0][0]).tag($0)
                    }
                }
                Picker(selection: $timer.alertSound, label: Text("Alerts")) {
                    ForEach(0 ..< soundData.alerts.count) {
                        Text(self.soundData.alerts[$0][0]).tag($0)
                    }
                }
            }
        }
    }
}
