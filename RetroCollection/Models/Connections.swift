//
//  Connections.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/27/21.
//

import Foundation

struct Connection: Codable, Identifiable, Initable {
    var id = UUID()
    
    var type: ConnectionTypes = .unknown
    var count: Int = 1
    var format: String = ""
}

enum ConnectionTypes: String, Codable, CaseIterable, Identifiable {
    case unknown = "Unknown"
    case keyboard = "Keyboard"
    case serial = "Serial"
    case parallel = "Parallel"
    case joystick = "Joystick"
    case ps2 = "PS/2"
    
    case vga = "VGA"
    case dvi = "DVI"
    case hdmi = "HDMI"
    case dp = "Display Port"
    case mdp = "Mini Display Port"
    case svideo = "SVideo"
    
    case audioin = "Audio In"
    case audioout = "Audio Out"
    case ethernet = "Ethernet"
    case telephone = "Telephone"
    case pcmcia = "PCMCIA"
    case adb = "ADB"
    case firewire = "FireWire"
    case thunderbolt = "Thunderbolt"
    case usb = "USB"
    case scsi = "SCSI"
    
    var id: Self { self }
    var displayName: String { rawValue }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        
        switch status {
        case "Keyboard": self = .keyboard
        case "Serial": self = .serial
        case "Parallel": self = .parallel
        case "Joystick": self = .joystick
        case "PS/2": self = .ps2
            
        case "VGA": self = .vga
        case "DVI": self = .dvi
        case "HDMI": self = .hdmi
        case "Display Port": self = .dp
        case "Mini Display Port": self = .mdp
        case "SVideo": self = .svideo
            
        case "Audio In": self = .audioin
        case "Audio Out": self = .audioout
        case "Ethernet": self = .ethernet
        case "Telephone": self = .telephone
        case "PCMCIA": self = .pcmcia
        case "ADB": self = .adb
        case "FireWire": self = .firewire
        case "Thunderbolt": self = .thunderbolt
        case "USB": self = .usb
        case "SCSI": self = .scsi
        
        default: self = .unknown
        }
    }
}
