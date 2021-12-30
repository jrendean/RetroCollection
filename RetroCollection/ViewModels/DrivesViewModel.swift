//
//  Drives.swift
//  RetroCollection
//
//  Created by JR Endean on 12/28/21.
//

import Foundation

extension Drive {
    
    var formattedSize: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        //return "\(formatter.string(from: NSNumber(value: size ?? 0)) ?? "0") \(sizeType?.rawValue ?? SizeTypes.unknown.rawValue)"
        return "\(formatter.string(from: NSNumber(value: size)) ?? "0") \(sizeType.rawValue)"
    }
}
