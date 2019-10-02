//
//  EditTimerForm.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 8/30/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI

struct EditTimerForm: View {
    @ObservedObject var timer: TimerEntity
    @State var updatedName: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Timer")) {
                TextField("Name", text: $updatedName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onAppear {
                        // Set the text field's initial value when it appears
                        self.updatedName = self.timer.name ?? "New Timer"
                }
            }
            NavigationLink(destination: EditTimesForm(timer: timer)) {
                Text("Edit times").font(.headline).foregroundColor(.black)
            }
            NavigationLink(destination: EditSoundsForm(timer: timer)) {
                Text("Edit sounds").font(.headline).foregroundColor(.black)
            }
        }
    }
}


