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
    var displayValues: [String]
    var index: Int
    var width: CGFloat
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(self.label)
            Picker("Picker", selection: self.$sounds.sounds.array[index]) {
                ForEach(0 ..< self.displayValues.count) {
                    Text(self.displayValues[$0]).tag(self.displayValues[$0])
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(maxWidth: width)
            .clipped()
            .border(Color.black)
        }
    }
}

struct SoundPicker: View {
    @Binding var sounds: Sonus
    var labels: [String] = ["Alarm", "Alert"]
    var displayValues: [[String]] = SoundFileData.Sounds

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 5) {
                HStack(spacing: 0) {
                    ForEach(0 ..< self.labels.count) { index in
                        SoundPickerView(sounds: self.$sounds,
                                        label: self.labels[index],
                                        displayValues: self.displayValues[index],
                                        index: index,
                                        width: (geometry.size.width * 0.9) / 2)
                    }
                }.frame(minWidth: geometry.size.width * 0.95, idealWidth: geometry.size.width * 0.95, maxWidth: geometry.size.width * 0.95, alignment: .center)
            }
        }
    }
}
