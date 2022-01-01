//
//  RetroCollection.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

import Foundation

struct RetroCollectionItem: Codable, Identifiable {
    var id = UUID()
    
    // TODO: enum Laptop, Desktop
    var type: String = ""
    
    var manufacturer: String = ""
    var name: String = ""
    var model: String = ""
    
    var modelNumber: String = ""
    var productFamily: String = ""
    var alsoKnownAs: String = ""
    var codeName: String = ""
    var serialNumber: String = ""
    
    var releasedDate: Date = Date.distantPast
    var discontinuedDate: Date = Date.distantFuture
    
    var cpu: CPU = CPU()
    
    var ram: [RAM] = []
    
    var operatingSystems: [OperatingSystem] = []
    
    var drives: [Drive] = []
    
    var screen: Screen = Screen()
    
    var motherboard: Motherboard = Motherboard()
    
    var expansions: [ExpansionCard] = []
    
    var connections: [Connection] = []
    
    var maintenance: Maintenance = Maintenance()
    
    var links: [String] = []
    //var photos: [Data]? = nil
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
    var name: String = ""
    var model: String = ""
    
    var memorySlots: Int = 0
    var expansionSlots: Int = 0
}


struct Battery: Codable {
    var size: String = ""
    var isWorking: Bool = true
    var type: String = ""
    var isRemoved: Bool = false
    var isReplaced: Bool = false
}

struct Screen: Codable {
    // TODO: Enum? tft, active, dstn?
    var type: String = ""
    var size: Double = 0
    var resolution: String = ""
    var bits: Int = 0
}

struct OperatingSystem: Codable, Identifiable, Initable {
    var id = UUID()
    
    var manufacturer: String = ""
    var name: String = ""

    var version: String = ""

    var links: [String] = []
}


struct Maintenance: Codable {
    var recapped: Bool = false
    var knownIssues: String = ""
    var notes: String = ""

    var batteryState: String = ""
}
