//
//  RetroCollection.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

import Foundation

struct RetroCollectionItem: Codable, Identifiable {
    var id = UUID()
    var manufacturer: String = ""
    var name: String = ""
    var modelNumber: String = ""
    
    var type: String = ""
    var productFamily: String = ""
    var model: String = ""
    var alsoKnownAs: String?
    var codeName: String?
    var serialNumber: String = ""
    
    var releasedDate: Date?
    var discontinuedDate: Date?
    
    var cpu: CPU = CPU()
    
    var ram: [RAM] = []
    
    var operatingSystems: [OperatingSystem] = []
    
    var drives: [Drive] = []
    
    var screen: Screen?
    
    var motherboard: Motherboard?
    
    var expansions: [ExpansionCard] = []
    
    var connections: [Connection] = []
    
    var maintenance: Maintenance?

    var links: [String]?
    var photos: [Data]?
}


struct CPU: Codable {
    var manufacturer: String = ""
    var name: String = ""
    var model: String = ""
    var family: String = ""
    
    var speed: Double = 0
    var speedType: SpeedTypes = .unknown
    
    var bits: Int = 0
    
    var L1CacheSize: Int? = nil
    var L1CacheSizeType: SizeTypes? = nil
    var L2CacheSize: Int? = nil
    var L2CacheSizeType: SizeTypes? = nil
}

struct Motherboard: Codable {
    var manufacturer: String = ""
    var model: String = ""
    
    var memorySlots: Int = 0
    var expansionSlots: Int = 0
}

struct RAM: Codable {
    var size: Int = 0
    var sizeType: SizeTypes = .unknown
    
    var type: String = ""
    
    var package: RAMPackages = .unknown
}

struct Battery: Codable {
    var size: String = ""
    var isWorking: Bool = true
    var type: String = ""
    var isRemoved: Bool = false
    var isReplaced: Bool = false
}

enum SpeedTypes: String, Codable, CaseIterable {
    case unknown = "Unknown"
    case mhz = "Mhz"
    case ghz = "GHz"
    

    
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

enum SizeTypes: String, Codable, CaseIterable, Identifiable {
    case unknown = "Unknown"
    case kb = "KB"
    case mb = "MB"
    case gb = "GB"
    case tb = "TB"
    
    var id: Self { self }
    var displayName: String { rawValue }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        
        switch status {
        case "KB": self = .kb
        case "MB": self = .mb
        case "GB": self = .gb
        case "TB": self = .tb
        default: self = .unknown
        }
    }
}

enum RAMPackages: String, Codable, CaseIterable {
    case unknown = "Unknown"
    case dip = "DIP"
    case sipp = "SIPP"
    case simm = "SIMM"
    case dimm = "DIMMM"
    case sodimm = "SODIMM"
    case onboard = "Onboard"
    
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

struct Screen: Codable {
    // TODO: Enum? tft, active, dstn?
    var type: String = ""
    var size: Double = 0
    var resolution: String = ""
    var bits: Int = 0
}

struct OperatingSystem: Codable, Identifiable {
    var id = UUID()
    
    var name: String = ""
    var manufacturer: String = ""
    
    var version: String = ""

    var links: [String]? = nil
}


struct Maintenance: Codable {
    var recapped: Bool = false
    var knownIssues: String = ""
    var notes: String = ""
    
    var batteryState: String = ""
}
