//
//  Battery.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import Foundation

struct Battery: Codable {
    var size: String = ""
    var isWorking: Bool = true
    var type: String = ""
    var isRemoved: Bool = false
    var isReplaced: Bool = false
}
