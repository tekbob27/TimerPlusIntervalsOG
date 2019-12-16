//
//  TimerSubstitute.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/27/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI
import CoreData

class TempusBrevis: ObservableObject, TempusInterruptus {
    var duration: Tempus = Tempus()
    
    var interlude: Tempus = Tempus()
    
    var sounds: [String] = ["", ""]
    
    var name: String = ""
    
    public static var count = 0
    
    init() {
        self.name = "New Timer 0"
        TempusBrevis.count = 0
    }

    init(count: Int) {
        self.name = "New Timer \(count))"
        TempusBrevis.count = count
    }
    
    func toString(_ part: String? = nil) -> String {
        switch part {
            case "duration":
                return duration.toString()
            case "interlude":
                return interlude.toString()
            case "alarm":
                return sounds.isEmpty || sounds.count < 2 ? "" : sounds[0]
            case "interrupt":
                return sounds.isEmpty || sounds.count < 2 ? "" : sounds[1]
            default:
                return self.name
        }
    }
}
