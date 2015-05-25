//
//  DateHelper.swift
//  WeatherForecast
//
//  Created by Hongbin Yang on 5/25/15.
//  Copyright (c) 2015 Hongbin Yang. All rights reserved.
//

import Foundation

extension Int {
    var days: NSTimeInterval {
        let DAY_IN_SECONDS = 60 * 60 * 24
        var days:Double = Double(DAY_IN_SECONDS) * Double(self)
        return days
    }
}
