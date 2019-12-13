//
//  TempusFactory.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/27/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import Foundation
import CoreData

enum TempusGenus {
    case TempusVigilia, TempusBrevia
}

struct TempusFactory {
    static func TempusGenitoris(genus: TempusGenus, context: NSManagedObjectContext) -> TempusInterruptus {
        switch genus {
            case .TempusBrevia:
                return TempusBrevis()
            case .TempusVigilia:
                return self.addTimer(context: context)
        }
    }
    
    func createTimer(newTimer: TempusBrevis, context: NSManagedObjectContext) -> Timers {
        return TempusFactory.addTimer(newTimer: newTimer, context: context)
    }
    
    private static func addTimer(context: NSManagedObjectContext) -> Timers {
        let timer = Timers(context: context)
        timer.duration = Duration(context: context)
        timer.interlude = Interlude(context: context)
        timer.order = Int64(TempusBrevis.count)
        timer.id = UUID().uuidString
        timer.name = "New Timer 0"
        return timer
    }
    
    private static func addTimer(newTimer: TempusBrevis, context: NSManagedObjectContext) -> Timers {
        let timer = addTimer(context: context)
        timer.dComponents = newTimer.duration.interval
        timer.iComponents = newTimer.interlude.interval
        timer.sounds = newTimer.sounds
        timer.name = newTimer.name != "" ? newTimer.name :  "New Timer \(TempusBrevis.count)"
        return timer
    }
}
