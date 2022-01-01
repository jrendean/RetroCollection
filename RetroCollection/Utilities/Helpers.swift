//
//  Helpers.swift
//  RetroCollection
//
//  Created by JR Endean on 12/29/21.
//

import Foundation
import SwiftUI

struct Helpers {
    
    static func DecimalHelper() -> NumberFormatter {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    static var viewPaddingSize: CGFloat = 10
}

