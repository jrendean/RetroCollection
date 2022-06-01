//
//  RestroCollectionItem.swift
//  RetroCollection
//
//  Created by JR Endean on 12/28/21.
//

import Foundation

extension ComputerCollectionItem {
    
    var releasedDateFormatted: String {
        if (releasedDate == Date.distantPast) {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
          
        return formatter.string(from: releasedDate)
    }
    
    var discontinuedDateFormatted: String {
        if (discontinuedDate == Date.distantFuture) {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
          
        return formatter.string(from: discontinuedDate)
    }
    
    var totalRam: String {
        var totalRam = 0
        var sizeData: String = SizeTypes.unknown.rawValue
        
        // TODO: issues
        // 512mb + 512mb = 1024mb -> 1gb?
        // 512mb + 1gb = 513gb
        // 1gb + 512mb = 512mb
        for r in ram {
            totalRam += r.size
            sizeData = r.sizeType.rawValue
        }
        
        return "\(totalRam) \(sizeData)"
    }
    
    var processorInfo: String {
        return "\(cpu.model) \(Helpers.DecimalHelper().string(from: NSNumber(value: cpu.speed)) ?? "0") \(cpu.speedType.displayName)"
    }
    
    
    
    var validView: Bool {
        type != "" &&
        manufacturer != "" &&
        name != ""
    }
    
}
