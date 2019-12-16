//
//  Sonus.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/29/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI
import Combine

class Sonus: ObservableObject {

    @Published var alarm: String = "" {
        willSet {
            self.objectWillChange.send()
        }
    }

    @Published var interrupt: String = ""
    {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    @ObservedObject var sounds: ObservableArray<String> = ObservableArray<String>(array: []) {
        willSet {
            self.objectWillChange.send()
        }
        didSet {
            self.alarm = self.sounds.array[0]
            self.interrupt = self.sounds.array[1]
        }
    }


    init() {
        self.sounds = ObservableArray<String>(array: [self.alarm, self.interrupt])
    }

    init(alarm: String, interrupt: String) {
        self.alarm = alarm
        self.interrupt = interrupt
        self.sounds = ObservableArray<String>(array: [alarm, interrupt])
    }
}
