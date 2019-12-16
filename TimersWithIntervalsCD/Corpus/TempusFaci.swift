//
//  TempusCorpus.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 12/13/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI
import CoreData

class TempusFaci {

    public static func update(from tempus: TempusNova, context: NSManagedObjectContext) {
        let timers = try! context.fetch(Timers.timersWithPredicateFetchRequest(predicate: NSPredicate(format: "id == %@", tempus.id)))
        if timers.count != 0 {
            if let timer = timers.first {
                timer.duration.components = tempus.duration.interval.array
                timer.interlude.components = tempus.interlude.interval.array
                if timer.name != tempus.name {
                    timer.name = tempus.name
                }
                if timer.duration.sound != tempus.sound.alarm {
                    timer.duration.sound = tempus.sound.alarm
                }
                
                if timer.interlude.sound != tempus.sound.interrupt {
                    timer.interlude.sound = tempus.sound.interrupt
                }
            }
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }

    public static func make(from timer: Timers, copyTo tempus: TempusNova = TempusNova()) -> TempusNova {
        tempus.duration.interval.array = timer.duration.components
        tempus.interlude.interval.array = timer.interlude.components
        tempus.name = timer.name
        tempus.sound.sounds = ObservableArray(array: [ timer.duration.sound, timer.interlude.sound ])
        tempus.id = timer.id
        return tempus
    }
    
    private static func add(context: NSManagedObjectContext) -> Timers {
        TempusNova.count = try! context.count(for: Timers.fetchRequest()) + 1
        let timer = Timers(context: context)
        timer.duration = Duration(context: context)
        timer.interlude = Interlude(context: context)
        timer.order = Int64(TempusNova.count)
        timer.id = UUID().uuidString
        timer.name = "New Timer 0"
        return timer
    }
    
    public static func add(from newTimer: TempusNova, context: NSManagedObjectContext) {
        let timer = add(context: context)
        timer.duration.components = newTimer.duration.interval.array
        timer.interlude.components = newTimer.interlude.interval.array
        timer.duration.sound = newTimer.sound.alarm
        timer.interlude.sound = newTimer.sound.interrupt
        timer.name = newTimer.name != "" ? newTimer.name :  "New Timer \(TempusNova.count)"
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
