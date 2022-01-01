//
//  RAM.swift
//  RetroCollection
//
//  Created by JR Endean on 12/30/21.
//

import Foundation

struct RAM: Codable {
    var size: Int = 0
    var sizeType: SizeTypes = .unknown
    
    var type: String = ""
    
    var package: RAMPackages = .unknown
}

enum RAMPackages: String, Codable, CaseIterable, Identifiable {
    case unknown = "Unknown"
    case dip = "DIP"
    case sipp = "SIPP"
    case simm = "SIMM"
    case dimm = "DIMMM"
    case sodimm = "SODIMM"
    case onboard = "Onboard"
    
    var id: Self { self }
    var displayName: String { rawValue }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        
        switch status {
        case "DIP": self = .dip
        case "SIPP": self = .sipp
        case "SIMM": self = .simm
        case "DIMM": self = .dimm
        case "SODIMM": self = .sodimm
        case "Onboard": self = .onboard
        default: self = .unknown
        }
    }
}
