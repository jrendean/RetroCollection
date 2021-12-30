//
//  Drives.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/27/21.
//

import Foundation


struct Drive: Codable, Identifiable {
    var id = UUID()
    
    var manufacturer: String = ""
    var model: String = ""
    
    var type: DriveTypes = .unknown
    var interface: DriveInterfaces = .unknown
    
    var size: Double = 0 //?
    var sizeType: SizeTypes = .unknown //?
    
    var isWorking: Bool = true
}


enum DriveTypes: String, Codable, CaseIterable {
    case unknown = "Unknown"
    case floppy35 = "3.5\" Floppy"
    case floppy525 = "5.25\" Floppy"
    case harddrive = "Hard Drive"
    case compactflash = "Compact Flash"
    case sdcard = "SD Card"
    case ssd = "SSD"
    case cd = "CD"
    case cdrw = "CDRW"
    case dvd = "DVD"
    case dvdrw = "DVDRW"
    case zip = "Zip"
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        
        switch status {
        case "3.5\" Floppy": self = .floppy35
        case "5.25\" Floppy": self = .floppy525
        case "Hard Drive": self = .harddrive
        case "Compact Flash": self = .compactflash
        case "SD Card": self = .sdcard
        case "SSD": self = .ssd
        case "CD": self = .cd
        case "CDRW": self = .cdrw
        case "DVD": self = .dvd
        case "DVDRW": self = .dvdrw
        case "Zip": self = .zip
        default: self = .unknown
        }
    }
}

enum DriveInterfaces: String, Codable, CaseIterable {
    case unknown = "Unknown"
    case floppy = "Floppy"
    case mfm = "MFM"
    case ide = "IDE"
    case eide = "EIDE"
    case sata = "SATA"
    case msata = "mSATA"
    case scsi = "SCSI"
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        
        switch status {
        case "Floppy": self = .floppy
        case "MFM": self = .mfm
        case "IDE": self = .ide
        case "EIDE": self = .eide
        case "SATA": self = .sata
        case "mSATA": self = .msata
        case "SCSI": self = .scsi
        default: self = .unknown
        }
    }
}
