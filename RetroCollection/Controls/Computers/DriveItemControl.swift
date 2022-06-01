//
//  DriveView.swift
//  RetroCollection
//
//  Created by JR Endean on 12/29/21.
//

import SwiftUI

struct DriveItemControl: View {

    @Binding var editorConfig: EditorConfig<Drive>
    //@State private var driveSize: String = String(editorConfig.data.size)
    
    var body: some View {
        
        NavigationView {
        
            VStack(alignment: .leading) {
                HStack {
                    Text("Manufacturer:")
                    Spacer()
                    if editorConfig.mode == .view {
                        Text(editorConfig.data.manufacturer)
                    } else {
                        TextField("Manufacturer", text: $editorConfig.data.manufacturer)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding(.all, editorConfig.mode == .view ? Helpers.viewPaddingSize : 0)
                
                HStack {
                    Text("Model:")
                    Spacer()
                    if editorConfig.mode == .view {
                        Text(editorConfig.data.model)
                    } else {
                        TextField("Model", text: $editorConfig.data.model)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding(.all, editorConfig.mode == .view ? Helpers.viewPaddingSize : 0)
                
                HStack {
                    Text("Type:")
                    Spacer()
                    if editorConfig.mode == .view {
                        Text(editorConfig.data.type.displayName)
                    } else {
                        Picker(
                            selection: $editorConfig.data.type,
                            label: Text("Type")) {
                                ForEach(DriveTypes.allCases, id: \.self) { type in
                                    Text(type.rawValue).tag(type)
                                }
                            }
                    }
                }
                .padding(.all, editorConfig.mode == .view ? Helpers.viewPaddingSize : 0)
                
                HStack {
                    Text("Interface:")
                    Spacer()
                    if editorConfig.mode == .view {
                        Text(editorConfig.data.interface.displayName)
                    } else {
                        Picker(
                            selection: $editorConfig.data.interface,
                            label: Text("Interfacessss")) {
                                ForEach(DriveInterfaces.allCases, id: \.self) { interface in
                                    Text(interface.rawValue).tag(interface)
                                }
                            }
                    }
                }
                .padding(.all, editorConfig.mode == .view ? Helpers.viewPaddingSize : 0)
                
                if editorConfig.mode == .view {
                    HStack {
                        Text("Size:")
                        Spacer()
                        Text(editorConfig.data.formattedSize)
                    }
                    .padding(.all, editorConfig.mode == .view ? Helpers.viewPaddingSize : 0)
                } else {
                    VStack {
                        HStack {
                            Text("Size:")
                            Spacer()
                            
                            TextField("Size", value: $editorConfig.data.size, formatter: Helpers.DecimalHelper())
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
                }
                
                if editorConfig.mode == .view {
                    HStack {
                        Text("Working:")
                        Spacer()
                        Text(editorConfig.data.isWorking ? "Yes" : "No")
                    }
                    .padding(.all, editorConfig.mode == .view ? Helpers.viewPaddingSize : 0)
                } else {
                    Toggle("Working", isOn: $editorConfig.data.isWorking)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("\(editorConfig.mode.rawValue) Drive")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction, content: {
                    Button(
                        action: {
                            editorConfig.dismiss()
                        },
                        label: { Text("Cancel") }
                    )
                })

                ToolbarItem(placement: .confirmationAction, content: {
                    if editorConfig.mode != .view {
                        Button(
                            action: {
                                editorConfig.dismiss(save: true)
                            },
                            label: { Text("Done") }
                        )
                        .disabled(editorConfig.mode == .view)
                    }
                })
            }
        }
    }
}


#if DEBUG
struct DriveItemControl_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State var testData: EditorConfig<Drive>
       
        var body: some View {
            DriveItemControl(editorConfig: $testData)
        }
    }
    
    static var previews: some View {
        Group {
            StatefulPreviewWrapper(
                testData: EditorConfig<Drive>(data: ComputerCollectionItem.testData[1].drives[2], mode: .view))

            StatefulPreviewWrapper(
                testData: EditorConfig<Drive>(data: ComputerCollectionItem.testData[1].drives[2], mode: .edit))
        }
    }
}
#endif
