//
//  InterruptedTimer.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/24/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import Foundation
import CoreData
import Combine
import AVFoundation

class TempusInterruptus: ObservableObject {
    // name of current time
    var name: String = ""
    var audioFilePlayer: AVAudioPlayer?
    
    // timings: duration is overall timer, interlude is the subtimer, elasped- starting value less the remaining times
    var duration: Double {
        get {
            if currentTimer != nil {
                return currentTimer?.duration.duration ?? 0.0
            }
            return 0.0
        }
        set {
            if currentTimer != nil {
                currentTimer?.duration.duration = newValue
            }
        }
    }
    
    var interlude: Double {
        get {
            if currentTimer != nil {
                return currentTimer?.interlude.duration ?? 0.0
            }
            return 0.0
        }
        set {
            if currentTimer != nil {
                currentTimer?.interlude.duration = newValue
            }
        }
    }
    
    var elapsedDuration: Double {
        get {
            if currentTimer != nil {
                return currentTimer?.duration.elapsed ?? 0.0
            }
            return 0.0
        }
        set {
            if currentTimer != nil {
                currentTimer?.duration.elapsed = newValue
            }
        }
    }
    
    var elapsedInterlude: Double {
        get {
            if currentTimer != nil {
                return currentTimer?.interlude.elapsed ?? 0.0
            }
            return 0.0
        }
        set {
            if currentTimer != nil {
                currentTimer?.interlude.elapsed = newValue
            }
        }
    }

    // noise names
    var interrupt: String = ""
    var alarm: String = ""

    @Published var interruptValue: String? = "00:00:00"
    @Published var durationValue: String? = "00:00:00"
    // core data element
    var currentTimer: Timers? = nil {
        didSet {
            alarm = currentTimer?.duration.sound ?? ""
            interrupt = currentTimer?.interlude.sound ?? ""
        }
    }
    
    // timer publishers
    var durationTimer: Timer?
    var audioTimer: Timer?

    init(_ iTimer: Timers) {
        currentTimer = iTimer
        interruptValue = iTimer.interlude.toString()
        durationValue = iTimer.duration.toString()
    }
    
    public func start() {
        durationTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }

    public func stop() {
        // play alarm and kill the timer
        durationTimer?.invalidate()
        durationTimer = nil
    }
    
    @objc public func stopAudio() {
        guard let player = audioFilePlayer else {
            return
        }
        if player.isPlaying {
            audioFilePlayer?.stop()
        }
    }

    @objc func onTimerFires() {
        self.elapsedInterlude += 1.0
        self.elapsedDuration += 1.0
        let triggerInterrupt = self.interlude == self.elapsedInterlude && self.duration != self.elapsedDuration
        let triggerAlarm = self.interlude == self.elapsedInterlude && self.duration == self.elapsedDuration
        interruptValue = currentTimer?.interlude.toString()
        durationValue = currentTimer?.duration.toString()

        if triggerInterrupt {
            // play interrupt and reset elapsedInterlude
            self.elapsedInterlude = 0
            playAudioFile(self.interrupt)
            audioTimer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(stopAudio), userInfo: nil, repeats: false)
        }
        
        if triggerAlarm {
            // play alarm and kill the timer
            durationTimer?.invalidate()
            durationTimer = nil
            self.elapsedDuration = 0
            playAudioFile(self.alarm)
            audioTimer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(stopAudio), userInfo: nil, repeats: false)
        }
    }
    
    func playAudioFile(_ file: String) {
        let path = Bundle.main.path(forResource: file, ofType:"caf")!
        let url = URL(fileURLWithPath: path)

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            audioFilePlayer = try AVAudioPlayer(contentsOf: url)
            audioFilePlayer?.play()
            audioFilePlayer?.numberOfLoops = -1
        } catch {
            // couldn't load file :(
            print("no file found")
        }
    }
}
