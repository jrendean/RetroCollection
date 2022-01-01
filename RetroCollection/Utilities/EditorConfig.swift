//
//  EditorConfig.swift
//  RetroCollection
//
//  Created by JR Endean on 12/29/21.
//

import Foundation

// done since no language support or base class stuff like c# where : new()
// https://stackoverflow.com/questions/43878118/swift-how-to-define-a-type-constraint-that-guarantee-the-type-has-an-init#43878146
protocol Initable {
    init()
}


// based on https://stackoverflow.com/questions/57233276/dismiss-sheet-swiftui answer from malhal
struct EditorConfig<T: Initable> {
    
    var data: T = T()
    var mode: Mode = .view
    var shouldShowView = false
    var shouldShowAdd = false
    var shouldShowEdit = false
    
    var needsSave = false
    
    mutating func present(mode: Mode, data: T) {
        self.mode = mode
        
        self.data = data
        
        resetModes()
        needsSave = false
        
        switch mode {
        case .view: self.shouldShowView = true
        case .edit: self.shouldShowEdit = true
        case .add: self.shouldShowAdd = true
        }
    }
    
    mutating func dismiss(save: Bool = false) {
        needsSave = save
        resetModes()
    }
    
    mutating func resetModes() {
        self.shouldShowAdd = false
        self.shouldShowView = false
        self.shouldShowEdit = false
    }
    
    enum Mode: String {
        case view = "View"
        case edit = "Edit"
        case add = "Add"
    }
}
