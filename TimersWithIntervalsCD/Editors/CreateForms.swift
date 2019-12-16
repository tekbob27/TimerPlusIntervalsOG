//
//  EditForms.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/27/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI

struct TimesForm: View {
    @ObservedObject var timer: TempusNova

    var body: some View {
        GeometryReader { geometry in
            Form {
                Section(header: HStack { Spacer()
                    Text("Timer Duration:")
                    Text("\(self.timer.duration.toString())").foregroundColor(Color.blue)
                    Spacer() },
                        content: {
                            HStack(alignment: .center, spacing: 0) {
                                VStack(alignment: .leading, spacing: 0.0) {
                                    TimePicker(time: self.$timer.duration)
                                }
                            }.frame(width: geometry.size.width * 0.95, height: 225.0, alignment: .center)
                })
                Section(header: HStack { Spacer()
                Text("Timer Interval:")
                Text("\(self.timer.interlude.toString())").foregroundColor(Color.blue)
                Spacer() },
                        content: {
                            HStack(alignment: .center, spacing: 0) {
                                VStack(alignment: .leading, spacing: 0.0) {
                                    TimePicker(time: self.$timer.interlude, labels: ["HH", "MM"], displayValues: [Array(0...24), Array(0...59)])
                                }
                            }.frame(width: geometry.size.width * 0.95, height: 225.0, alignment: .center)
                })
            }.frame(width: geometry.size.width, alignment: .center)
        }
    }
}

struct SoundsForm: View {
    @ObservedObject var timer: TempusNova
    
    var body: some View {
        GeometryReader { geometry in
            Form {
                Section(header:
                    ZStack(alignment: .leading) {
                        Text("Current")
                        HStack(alignment: .center) {
                            Spacer()
                            Text("\(self.timer.sound.alarm)").foregroundColor(Color.blue).font(.body)
                            Spacer()
                            Text("\(self.timer.sound.interrupt)").foregroundColor(Color.blue).font(.body)
                            Spacer()
                        }.background(Color.clear)
                    },
                        content: {
                    HStack(alignment: .center, spacing: 0) {
                        VStack(alignment: .leading, spacing: 10) {
                            Spacer()
                            SoundPicker(sounds: self.$timer.sound, labels: ["Alarm", "Interrupt"])
                            Spacer()
                        }
                    }.frame(width: geometry.size.width * 0.95, height: 225.0, alignment: .center)
                })
            }
        }
    }
}
