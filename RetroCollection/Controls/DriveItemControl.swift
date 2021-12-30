//
//  DriveView.swift
//  RetroCollection
//
//  Created by JR Endean on 12/29/21.
//

import SwiftUI
import Combine

struct DriveItemControl: View {

    @Binding var editorConfig: EditorConfig<Drive>

    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    //@State private var driveSize: String = String(editorConfig.data.size)
    
    var body: some View {
        
        NavigationView {
        
            VStack(alignment: .leading) {
                HStack {
                    Text("Manufacturer:")
                    Spacer()
                    TextField("Manufacturer", text: $editorConfig.data.manufacturer)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Model:")
                    Spacer()
                    TextField("Model", text: $editorConfig.data.model)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Type:")
                    Spacer()
                    Picker(
                        selection: $editorConfig.data.type,
                        label: Text("Type")) {
                            ForEach(DriveTypes.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                }
                
                HStack {
                    Text("Interface:")
                    Spacer()
                    Picker(
                        selection: $editorConfig.data.interface,
                        label: Text("Interfacessss")) {
                            ForEach(DriveInterfaces.allCases, id: \.self) { interface in
                                Text(interface.rawValue).tag(interface)
                            }
                        }
                }
                
                VStack {
                    HStack {
                        Text("Size:")
                        Spacer()
                        TextField("Size", value: $editorConfig.data.size, formatter: formatter)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            /*
                            .onReceive(Just(driveSize)) { inputValue in
                                let filtered = inputValue.filter { "0123456789".contains($0) }
                                if filtered != inputValue {
                                    self.driveSize = filtered
                                    editorConfig.data.size = Double(filtered)
                                }
                            }
                            */
                    }
                    
                    Picker(
                        selection: $editorConfig.data.sizeType,
                        label: Text("Sizes")) {
                            ForEach(SizeTypes.allCases) { size in
                                Text(size.displayName).tag(size.id)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    
                }
                
                Toggle("Working", isOn: $editorConfig.data.isWorking)
                
                Spacer()
            }
            .padding()
            .navigationTitle("\(editorConfig.mode.rawValue) Drive")
            .navigationBarTitleDisplayMode(.inline)
            .disabled(editorConfig.mode == .view)
            .toolbar {
                ToolbarItem(placement: .cancellationAction, content: {
                    Button(
                        action: {
                            editorConfig.dismiss()
                        },
                        label: { Text("Close") }
                    )
                })
                
                //if (editorConfig.mode != .view ) {
                    ToolbarItem(placement: .confirmationAction, content: {
                        Button(
                            action: {
                                editorConfig.dismiss(save: true)
                            },
                            label: { Text("Save") }
                        )
                        .disabled(editorConfig.mode == .view)
                    })
                //}
            }
        }
    }
}



struct EditorConfig<T> {
    
    //var data: T = nil
    var data: Drive = Drive()
    var mode: Mode = .view
    var shouldShowView = false
    var shouldShowAdd = false
    var shouldShowEdit = false
    
    var needsSave = false
    
    //mutating func present(mode: Mode, data: T) {
    mutating func present(mode: Mode, data: Drive) {
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





#if DEBUG
struct DriveView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var testData = EditorConfig<Drive>(data: RetroCollectionItem.testData[1].drives[2], mode: .view)
       
        var body: some View {
            DriveItemControl(editorConfig: $testData)
        }
    }
    
    static var previews: some View {
         
        Group {
            NavigationView {
                StatefulPreviewWrapper()
            }
            
            NavigationView {
                StatefulPreviewWrapper()
                    .preferredColorScheme(.dark)
            }
        }
    }
}
#endif
