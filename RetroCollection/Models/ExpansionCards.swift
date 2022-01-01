//
//  ExpansionCards.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/27/21.
//

import Foundation

struct ExpansionCard: Codable, Identifiable, Initable {
    var id = UUID()
    
    var manufacturer: String = ""
    var name: String = ""
    var model: String = ""
    
    var type: ExpansionCardTypes = .unknown
    var interface: ExpansionCardInterfaces = .unknown
    
    var driverLinks: [String] = []
}

enum ExpansionCardTypes: String, Codable, CaseIterable, Identifiable {
    case unknown = "Unknown"
    case video = "Video"
    case ethernet = "Ethernet"
    case wifi = "WiFi"
    case sound = "Sound"
    case modem = "Modem"
    case scsi = "SCSI"
    case multi = "Multipurpose"
        
    var id: Self { self }
    var displayName: String { rawValue }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        
        switch status {
        case "Video": self = .video
        case "Ethernet": self = .ethernet
        case "WiFi": self = .wifi
        case "Sound": self = .sound
        case "Modem": self = .modem
        case "Multipurpose": self = .multi
        case "SCSI": self = .scsi
        default: self = .unknown
        }
    }
}

enum ExpansionCardInterfaces: String, Codable, CaseIterable, Identifiable {
    case unknown = "Unknown"
    case isa8 = "ISA (8)"
    case isa16 = "ISA (16)"
    case vlb = "VLB"
    case pci = "PCI"
    case pcie = "PCIE"
    case pcmcia = "PCMCIA"
    case agp = "AGP"
    
    var id: Self { self }
    var displayName: String { rawValue }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        
        switch status {
        case "ISA (8)": self = .isa8
        case "ISA (16)": self = .isa16
        case "VLB": self = .vlb
        case "PCI": self = .pci
        case "PCIE": self = .pcie
        case "PCMCIA": self = .pcmcia
        case "AGP": self = .agp
        default: self = .unknown
        }
    }
}
