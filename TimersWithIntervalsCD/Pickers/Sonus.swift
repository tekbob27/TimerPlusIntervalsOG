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

    @Published var alarm: String = "alarm" {
        willSet {
            self.objectWillChange.send()
        }
        didSet {
            print(self.alarm)
        }
    }

    @Published var interrupt: String = "interrupt"
    {
        willSet {
            self.objectWillChange.send()
        }
        didSet {
            print(self.interrupt)
        }
    }
    
    @ObservedObject var sounds: ObservableArray<String> = ObservableArray<String>(array: []) {
        didSet {
            if self.sounds.array[0] != self.alarm {
                print(self.sounds.array[0])
                self.alarm = self.sounds.array[0]
            }
            if self.sounds.array[1] != self.interrupt {
                print(self.sounds.array[1])
                self.interrupt = self.sounds.array[1]
            }
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
