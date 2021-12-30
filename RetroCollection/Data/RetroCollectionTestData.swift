//
//  RetroCollectionTestData.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

import Foundation

extension RetroCollectionItem {
    static var testData: [RetroCollectionItem]
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return [
            RetroCollectionItem(
                manufacturer: "Apple",
                name: "PowerBook FireWire",
                modelNumber: "M7573",
                type: "Laptop",
                productFamily: "PowerBook",
                model: "PowerBook 3,1",
                codeName: "Pismo",
                serialNumber: "QT03694NK34",
                //orderNumber: "M7711LL/A",
                releasedDate: dateFormatter.date(from: "2000-2-16"),
                discontinuedDate: dateFormatter.date(from: "2001-1-9"),
                
                cpu: CPU(
                    manufacturer: "",
                    name: "PowerPC",
                    model: "G3",
                    family: "750",
                    speed: 400,
                    speedType: .mhz,
                    bits: 32,
                    L1CacheSize: 64,
                    L1CacheSizeType: .kb,
                    L2CacheSize: 1,
                    L2CacheSizeType: .mb
                ),
                
                ram: [
                    RAM(size: 64, sizeType: .mb, type: "PC-100", package: .sodimm),
                    RAM(size: 512, sizeType: .mb, type: "PC-133", package: .sodimm),
                ],
                
                operatingSystems: [
                    OperatingSystem(
                        name: "OS X Tiger",
                        manufacturer: "Apple",
                        version: "10.4.11",
                        links: ["https://en.wikipedia.org/wiki/Mac_OS_X_Tiger"]),
                    OperatingSystem(
                        name: "MacOS",
                        manufacturer: "Apple",
                        version: "9.2.2",
                        links: ["https://en.wikipedia.org/wiki/Mac_OS_9"])
                ],
                
                drives: [
                    Drive(type: .compactflash, interface: .ide, size: 32, sizeType: .gb),
                    Drive(type: .dvd, interface: .ide)
                ],
                
                screen: Screen(
                    type: "TFT", size: 14.1, resolution: "1024x768", bits: 24
                ),
                
                expansions: [
                    ExpansionCard(manufacturer: "ATI", model: "Rage 128", type: .video, interface: .agp), // ram 8mb sdram
                    ExpansionCard(manufacturer: "Apple", model: "Airport", type: .wifi, interface: .pcmcia),
                    ExpansionCard(manufacturer: "Apple", model: "56k", type: .modem),
                ],
                
                connections: [
                    Connection(type: .usb, count: 2, format: "1.1"),
                    Connection(type: .firewire, format: "400"),
                    Connection(type: .pcmcia),
                    Connection(type: .vga),
                    Connection(type: .audioin),
                    Connection(type: .audioout),
                    Connection(type: .ethernet, format: "10/100"),
                    Connection(type: .telephone),
                    Connection(type: .svideo)
                ],
                
                maintenance: Maintenance(
                    knownIssues: "Case is cracked by DVD drive and by battery eject lever.",
                    notes: "some really long test with \n new lines and other junk in it. \n wowoww w"),
                
                links: [
                    "https://en.wikipedia.org/wiki/PowerBook_G3#PowerBook_Firewire_(Pismo)",
                    "https://www.ifixit.com/Device/PowerBook_G3_Pismo"
                ]
            ),
            
            RetroCollectionItem(
                manufacturer: "Packard Bell",
                name: "Pack-Mate 4100CD",
                type: "Desktop",
                
                cpu: CPU(manufacturer: "Intel", name: "Pentium", model: "Pentium", family: "Pentium", speed: 75, speedType: .mhz, bits: 32),
                
                ram: [
                    RAM(size: 8, sizeType: .mb, package: .onboard),
                    RAM(size: 16, sizeType: .mb, package: .simm),
                    RAM(size: 16, sizeType: .mb, package: .simm),
                    RAM(size: 16, sizeType: .mb, package: .simm)
                ],
                
                operatingSystems: [
                    OperatingSystem(name: "Windows", manufacturer: "Microsoft", version: "98")
                ],
                
                drives: [
                    Drive(type: .floppy35, interface: .floppy, size: 1.44, sizeType: .mb),
                    Drive(type: .floppy525, interface: .floppy, size: 360, sizeType: .kb),
                    Drive(manufacturer: "Seagate", type: .harddrive, interface: .ide, size: 3.2, sizeType: .gb),
                    Drive(manufacturer: "Sony NEC Optiarc Inc.", model: "AD-7170A", type: .dvdrw, interface: .ide),
                ],
                
                motherboard: Motherboard(manufacturer: "Packard Bell", model: "", memorySlots: 4, expansionSlots: 5),
                
                expansions: [
                    // gpu Mach64 GT-B
                    // ram 4mb
                    ExpansionCard(manufacturer: "ATI", name: "3D Rage II", model: "264VT3", type: .video, interface: .pci, driverLinks: ["https://www.techpowerup.com/gpu-specs/3d-rage-ii.c873"]),
                    ExpansionCard(manufacturer: "Creative Labs", name: "Vibra 16XV", model: "CT4170", type: .sound, interface: .isa16, driverLinks: ["https://oemdrivers.com/sound-sb16", "https://support.creative.com/Products/ProductDetails.aspx?prodID=1842&prodName=Sound%20Blaster%2016"]),
                    // speed 10/100
                    ExpansionCard(manufacturer: "3COM", name: "Fast EtherLink XL", model: "3C905C-TX", type: .ethernet, interface: .pci, driverLinks: ["https://oemdrivers.com/network-3com-3c905c-txm"]),
                ],
                
                connections: [
                    Connection(type: .vga),
                    Connection(type: .serial, format: "DB9"),
                    Connection(type: .parallel),
                    Connection(type: .ps2, count: 2),
                ]
            )
            
        ]
    }
}
