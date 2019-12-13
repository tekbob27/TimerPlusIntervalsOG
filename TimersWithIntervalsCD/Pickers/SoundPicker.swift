//
//  ContentView.swift
//  TestEditMode
//
//  Created by Bob O'Connor on 11/26/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI

struct SoundPickerView: View {
    @Binding var sounds: Sonus
    var label: String
    var color: Color
    var displayValues: [String]
    var index: Int
    var width: CGFloat
    
    
    var body: some View {
        Picker(selection: self.$sounds.sounds.array[index], label: Text(self.label)) {
            ForEach(0 ..< self.displayValues.count) {
                Text(self.displayValues[$0]).tag(self.displayValues[$0])
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(maxWidth: width)
        .clipped()
        .border(color)
    }
}

struct SoundPicker: View {
    @Binding var sounds: Sonus
    var labels: [String] = ["Alarm", "Alert"]
    var displayValues: [[String]] = SoundFileData.Sounds
    var colors: [Color] = [ Color.red, Color.blue ]

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(0 ..< self.labels.count) { index in
                        SoundPickerView(sounds: self.$sounds,
                                        label: self.labels[index],
                                        color: self.colors[index],
                                        displayValues: self.displayValues[index],
                                        index: index,
                                        width: geometry.size.width / 2)
                    }
                }.frame(minWidth: geometry.size.width * 0.95, idealWidth: geometry.size.width * 0.95, maxWidth: geometry.size.width * 0.95)
                Text("\(self.sounds.sounds.array[0]):\(self.sounds.sounds.array[1])")
            }
        }
    }
}
