//
//  Screen.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import Foundation

struct Screen: Codable {
    // TODO: Enum? tft, active, dstn?
    var type: String = ""
    var size: Double = 0
    var resolution: String = ""
    var bits: Int = 0
}
