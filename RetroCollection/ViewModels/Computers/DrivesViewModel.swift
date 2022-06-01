//
//  Drives.swift
//  RetroCollection
//
//  Created by JR Endean on 12/28/21.
//

import Foundation

extension Drive {
    
    var formattedSize: String {
        return "\(Helpers.DecimalHelper().string(from: NSNumber(value: size)) ?? "0") \(sizeType.rawValue)"
    }
}
