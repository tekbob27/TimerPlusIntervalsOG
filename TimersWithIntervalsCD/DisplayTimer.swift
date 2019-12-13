//
//  DisplayTimer.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/25/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI

struct DisplayTimer: View {
    @ObservedObject var interrupted: InterruptedTimer
    @ObservedObject var timer: Timers
    @State var showingEditor = false

    init(timer: Timers) {
        self.timer = timer
        self.interrupted = InterruptedTimer(timer)
    }
    var body: some View {
        NavigationView {
            VStack {
                VStack {    Text(self.$interrupted.durationValue.wrappedValue!).bold().font(.largeTitle).foregroundColor(Color.purple)
                    Text(self.$interrupted.interruptValue.wrappedValue!).bold().font(.body).foregroundColor(Color.purple)
                }
            }
        }.navigationBarTitle(Text("In Flight").font(.title).bold(), displayMode: .inline)
         .navigationBarItems(trailing: Button(action: { self.showingEditor = true }) { Text("Edit")})
         .sheet(isPresented: $showingEditor) { EditTimerForm(timer: self.timer) }
    }
}
