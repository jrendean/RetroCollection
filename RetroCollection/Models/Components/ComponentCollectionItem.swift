//
//  ComponentCollectionItem.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import Foundation

struct ComponentCollectionItem: Codable, Identifiable {
    var id = UUID()
    
    var type: String = ""
    
    var manufacturer: String = ""
    var name: String = ""
    var model: String = ""
    
    var modelNumber: String = ""
    /*
    var productFamily: String = ""
    var alsoKnownAs: String = ""
    var codeName: String = ""
    var serialNumber: String = ""
     */
    
    var releasedDate: Date = Date.distantPast
    var discontinuedDate: Date = Date.distantFuture
    
    /*
    var cpu: CPU = CPU()
    
    var ram: [RAM] = []
    
    var operatingSystems: [OperatingSystem] = []
    
    var drives: [Drive] = []
    
    var screen: Screen = Screen()
    
    var motherboard: Motherboard = Motherboard()
    
    var expansions: [ExpansionCard] = []
    */
    
    var connections: [Connection] = []
    
    var maintenance: Maintenance = Maintenance()
    
    var links: [String] = []
    var photos: [Photo] = []
}
