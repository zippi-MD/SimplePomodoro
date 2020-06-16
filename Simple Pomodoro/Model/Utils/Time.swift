//
//  Time.swift
//  Simple Pomodoro
//
//  Created by Alejandro Mendoza on 15/06/20.
//  Copyright © 2020 Alejandro Mendoza. All rights reserved.
//

import Foundation

struct TimeFormatter {
    static func formatSeconds(_ seconds: Int) -> String? {
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        
        let timeInterval = TimeInterval(seconds)
        
        return formatter.string(from: timeInterval)
        
    }
}
