//
//  ComponentCollectionItemViewModel.swift
//  RetroCollection
//
//  Created by JR Endean on 5/31/22.
//

import Foundation

extension ComponentCollectionItem {
    
    var validView: Bool {
        type != "" &&
        manufacturer != "" &&
        name != ""
    }
}
