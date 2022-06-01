//
//  Motherboard.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import Foundation

struct Motherboard: Codable {
    var manufacturer: String = ""
    var name: String = ""
    var model: String = ""
    
    var memorySlots: Int = 0
    var expansionSlots: Int = 0
}
