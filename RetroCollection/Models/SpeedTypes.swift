//
//  SpeedTypes.swift
//  RetroCollection
//
//  Created by JR Endean on 12/30/21.
//

import Foundation

enum SpeedTypes: String, Codable, CaseIterable, Identifiable {
    case unknown = "Unknown"
    case mhz = "MHz"
    case ghz = "GHz"
    
    var id: Self { self }
    var displayName: String { rawValue }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        
        switch status {
            case "MHz": self = .mhz
            case "GHz": self = .ghz
            default: self = .unknown
        }
    }
}
