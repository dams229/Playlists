//
//  TimeIntervalExtension.swift
//  Playlists
//
//  Created by Damien Dorizy on 23/09/2017.
//  Copyright © 2017 CfApps. All rights reserved.
//

import Foundation

extension TimeInterval {
    /// Formats a TimeInterval to a "00:00:00" format
    func toFormattedString() -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropLeading
        if let formatted = formatter.string(from: self) {
            // Avoid returning "50" for 50 seconds. Instead, returns "0:50"
            return self < 60 ? "0:" + formatted : formatted
        }
        return nil
    }
}
