//
//  BaseTimer.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 8/30/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import Foundation
import Combine

public protocol TimerProtocol {
    var id: String { get set }
    var name: String { get set }
    var duration: String { get set }
    var interval: String { get set }
    var order: Int64 { get set }
    var alertSound: String { get set }
    var alarmSound: String { get set }
}

public class BaseTimer: TimerProtocol, ObservableObject, Identifiable {
    static func == (lhs: BaseTimer, rhs: BaseTimer) -> Bool {
        return lhs.id == rhs.id
    }
    
    static let `default` = BaseTimer(duration: "00:30:00", interval: "00:05:00")
    
    enum Property: String {
        case id, name, isCompleted, sortIndex
    }
    
    let willChange = ObjectWillChangePublisher()
        
    public var id: String = ""
    public var name: String = "New Timer" {
        willSet { self.willChange.send() }
    }
    public var duration: String = "" {
        willSet { self.willChange.send() }
    }
    public var interval: String = "" {
        willSet { self.willChange.send() }
    }
    public var order: Int64 = 0
    
    public var alertSound: String = ""  {
       willSet { self.willChange.send() }
    }
    public var alarmSound: String = "" {
       willSet { self.willChange.send() }
    }
    
    convenience init(duration: String, interval: String) {
        self.init()
        self.id = UUID().uuidString
        self.duration = duration
        self.interval = interval
    }
}

