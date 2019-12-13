//
//  TempusInterruptus.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/27/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import Foundation

protocol TempusInterruptus {
    var sounds: [String] { get set }
    var name: String { get set }
    func toString(_ part: String?) -> String
}
