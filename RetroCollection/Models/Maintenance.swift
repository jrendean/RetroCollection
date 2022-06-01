//
//  Maintenance.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import Foundation

struct Maintenance: Codable {
    var recapped: Bool = false
    var knownIssues: String = ""
    var notes: String = ""

    var batteryState: String = ""
}
