//
//  GamingCollectionItemViewModel.swift
//  RetroCollection
//
//  Created by JR Endean on 5/31/22.
//

import Foundation


extension GamingCollectionItem {
    
    var validView: Bool {
        type != "" &&
        manufacturer != "" &&
        name != ""
    }
}
