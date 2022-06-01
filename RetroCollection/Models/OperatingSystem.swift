//
//  OperatingSystem.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import Foundation

struct OperatingSystem: Codable, Identifiable, Initable {
    var id = UUID()
    
    var manufacturer: String = ""
    var name: String = ""

    var version: String = ""

    var links: [String] = []
}
