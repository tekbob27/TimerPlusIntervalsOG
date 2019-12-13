//
//  TimerProtocol.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/27/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI

protocol TempusInterruptus: ObservableObject, Identifiable {
    var dComponents: [ Int64 ] { get set }
    var iComponents: [ Int64 ] { get set }
    var sounds: [ String ] { get set }
    var name: String { get set }
    var id: String { get set }
    func toString(_ part: String?) -> String
    
    func compare<T: TempusInterruptus>(_ thing1: T, against thing2: T) -> Bool 
}
