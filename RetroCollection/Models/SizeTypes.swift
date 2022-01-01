//
//  SizeTypes.swift
//  RetroCollection
//
//  Created by JR Endean on 12/30/21.
//

import Foundation

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
