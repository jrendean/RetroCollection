//
//  ConnectionItemControl.swift
//  RetroCollection
//
//  Created by JR Endean on 12/30/21.
//

import SwiftUI

struct ConnectionItemControl: View {
    
    @Binding var editorConfig: EditorConfig<Connection>
    
    var body: some View {
        
        NavigationView {
        
            VStack(alignment: .leading) {
                
                HStack {
                    Text("Connection Type:")
                    Spacer()
                    if editorConfig.mode == .view {
                        Text(editorConfig.data.type.displayName)
                    } else {
                        Picker("Connection Type:", selection: $editorConfig.data.type)
                            {
                                /*
                                 ForEach(ConnectionTypes.allCases, id: \.self) { connection in
                                    Text(connection.rawValue).tag(connection)
                                }*/
                                ForEach(ConnectionTypes.allCases) { connection in
                                    Text(connection.displayName).tag(connection.id)
                                }
                            }
                    }
                }
                .padding(.all, editorConfig.mode == .view ? Helpers.viewPaddingSize : 0)
                
                if editorConfig.mode == .view {
                    HStack {
                        Text("Count:")
                        Spacer()
                        Text(String(editorConfig.data.count))
                    }
                    .padding(.all, editorConfig.mode == .view ? Helpers.viewPaddingSize : 0)
                } else {
                    Stepper(value: $editorConfig.data.count, in: 1...5, step: 1) {
                        HStack {
                            Text("Count:")
                            Spacer()
                            Text("\(editorConfig.data.count)").padding(.trailing)
                        }
                    }
                }
                
                HStack {
                    Text("Format:")
                    Spacer()
                    if editorConfig.mode == .view {
                        Text(editorConfig.data.format)
                    } else {
                        TextField("DB9, 400, 3.1, etc", text: $editorConfig.data.format)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding(.all, editorConfig.mode == .view ? Helpers.viewPaddingSize : 0)
                
                Spacer()
                
            }
            .padding()
            .navigationTitle("\(editorConfig.mode.rawValue) Connection")
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
struct ConnectionItemControl_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State var testData: EditorConfig<Connection>
       
        var body: some View {
            ConnectionItemControl(editorConfig: $testData)
        }
    }
    
    static var previews: some View {
        Group {
            StatefulPreviewWrapper(
                testData: EditorConfig<Connection>(data: ComputerCollectionItem.testData[1].connections[1], mode: .view))

            StatefulPreviewWrapper(
                testData: EditorConfig<Connection>(data: ComputerCollectionItem.testData[1].connections[1], mode: .edit))
        }
    }
}
#endif
