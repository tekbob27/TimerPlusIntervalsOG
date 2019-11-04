//
//  FileReader.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 8/31/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import Foundation

class SoundFileData {
    static var Alarms: [String] = []
    static var Alerts: [String] = []
    static var Lookup: [String:String] = [:]

    init() {
        readDataFromCSV("soundMap")
    }
    
    public func readDataFromCSV(_ fileName:String) {
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: "csv")
            else {
                return
        }
        do {
            csv(try String(contentsOfFile: filepath, encoding: .utf8))
            return
        } catch {
            print("File Read Error for file \(filepath)")
            return
        }
    }
    
    private func csv(_ data: String) {
        let rows = data.components(separatedBy: "\r")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            if columns.count == 4 {
                SoundFileData.Alarms.append(columns[0])
                SoundFileData.Lookup[columns[0]] = columns[1]
            } else {
                SoundFileData.Alerts.append(columns[0])
                SoundFileData.Lookup[columns[0]] = columns[1]
            }
        }
    }
}
