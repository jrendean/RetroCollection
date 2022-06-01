//
//  CPU.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import Foundation

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
