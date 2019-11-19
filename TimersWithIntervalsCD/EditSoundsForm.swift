//
//  EditSoundsForm.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 8/31/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI

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
        }.onDisappear() {
            try! self.timer.managedObjectContext?.save()
        }
    }
}
