//
//  ExpansionItemControl.swift
//  RetroCollection
//
//  Created by JR Endean on 12/30/21.
//

import SwiftUI

struct ExpansionItemControl: View {
    
    @Binding var editorConfig: EditorConfig<ExpansionCard>
    
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
                    Text("Name:")
                    Spacer()
                    if editorConfig.mode == .view {
                        Text(editorConfig.data.name)
                    } else {
                        TextField("Name", text: $editorConfig.data.name)
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
                            label: Text("Types")) {
                                ForEach(ExpansionCardTypes.allCases, id: \.self) { type in
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
                            label: Text("Interface")) {
                                 ForEach(ExpansionCardInterfaces.allCases, id: \.self) { interface in
                                    Text(interface.rawValue).tag(interface)
                                }
                            }
                    }
                }
                .padding(.all, editorConfig.mode == .view ? Helpers.viewPaddingSize : 0)
                
                Divider()
                
                VStack {
                    HStack {
                        Text("Links")
                        Spacer()
                    }
                    
                    if editorConfig.mode == .view {
                        ForEach($editorConfig.data.driverLinks, id: \.self) { $link in
                            HStack {
                                Text(.init("[\(link)](\(link))"))
                                    .lineLimit(1)
                                    .padding(2)
                                Spacer()
                            }
                        }
                    } else {
                        ForEach($editorConfig.data.driverLinks, id: \.self) { $link in
                            TextField("https://foo.com", text: $link)
                                .keyboardType(.URL)
                        }
                        .onDelete(perform: { indexSet in
                            editorConfig.data.driverLinks.remove(atOffsets: indexSet)
                        })
                        
                        Button(
                            action: {
                                editorConfig.data.driverLinks.append("")
                            },
                            label: {
                                HStack {
                                    Image(systemName: "plus.circle.fill").symbolRenderingMode(.multicolor)
                                    Text("add a link")
                                }
                            }
                        )
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("\(editorConfig.mode.rawValue) Expansion")
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
struct ExpansionItemControl_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State var testData: EditorConfig<ExpansionCard>
       
        var body: some View {
            ExpansionItemControl(editorConfig: $testData)
        }
    }
    
    static var previews: some View {
        Group {
            StatefulPreviewWrapper(
                testData: EditorConfig<ExpansionCard>(data: RetroCollectionItem.testData[1].expansions[1], mode: .view))

            StatefulPreviewWrapper(
                testData: EditorConfig<ExpansionCard>(data: RetroCollectionItem.testData[1].expansions[1], mode: .edit))
        }
    }
}
#endif
