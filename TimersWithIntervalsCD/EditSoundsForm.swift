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
    @Environment(\.managedObjectContext) var managedObjectContext

    @State var alarmSound: [String] = ["",""]
    @State var alertSound: [String] = []
    @State var sounds: [[String]] = []

    var body: some View {
        Form {
            Section(header: Text("Timer")) {
                Text("Name: \(timer.name!)")
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Section(header: Text("Sounds"),
                    footer: Text("Alarm: \(getAlarmSound())\tAlert: \(getAlertSound())"),
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
                                              selection: $alarmSound)
                            }
                        }.frame(width: UIScreen.main.bounds.size.width, height: 225.0, alignment: .center)
            })
        }.onAppear() {
            if self.alarmSound.count == 0 {
                self.alarmSound.append(self.timer.alarmSound ?? "")
                self.alertSound.append(self.timer.alertSound ?? "")
            } else {
                self.alarmSound[0] = self.timer.alarmSound ?? ""
                self.alarmSound[1] = self.timer.alertSound ?? ""
            }
            
            if self.sounds.count == 0 {
                self.sounds.append(SoundFileData.Alarms)
                self.sounds.append(SoundFileData.Alerts)
            }
        }.onDisappear() {
            try! self.timer.managedObjectContext?.save()
        }
    }
    
    func getAlarmSound() -> String {
        if self.alarmSound[0] != "" {
            self.timer.alarmSound = self.alarmSound[0]
        }
        return self.alarmSound[0]
    }
    
    func getAlertSound() -> String {
        if self.alarmSound[1] != "" {
            self.timer.alertSound = self.alarmSound[1]
        }
        return self.alarmSound[1]
    }
}
