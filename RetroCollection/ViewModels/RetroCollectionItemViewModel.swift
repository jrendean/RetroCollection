//
//  RestroCollectionItem.swift
//  RetroCollection
//
//  Created by JR Endean on 12/28/21.
//

import Foundation

extension RetroCollectionItem {
    
    var releasedDateFormatted: String {
        if let date = releasedDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
              
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
    
    var discontinuedDateFormatted: String {
        if let date = discontinuedDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
              
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
    
    var totalRam: String {
        var totalRam = 0
        var sizeData: String = SizeTypes.unknown.rawValue
        
        for r in ram {
            totalRam += r.size
            sizeData = r.sizeType.rawValue
        }
        
        return "\(totalRam) \(sizeData)"
    }
    
    var processorInfo: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return "\(cpu.model) \(formatter.string(from: NSNumber(value: cpu.speed)) ?? "0") \(cpu.speedType.rawValue)"
    }
}
