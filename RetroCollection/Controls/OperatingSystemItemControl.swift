//
//  OperatingSystemItemControl.swift
//  RetroCollection
//
//  Created by JR Endean on 12/30/21.
//

import SwiftUI

struct OperatingSystemItemControl: View {
    
    @Binding var editorConfig: EditorConfig<OperatingSystem>
    
    
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
                    Text("Version:")
                    Spacer()
                    if editorConfig.mode == .view {
                        Text(editorConfig.data.version)
                    } else {
                        TextField("Version", text: $editorConfig.data.version)
                            .multilineTextAlignment(.trailing)
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
                        ForEach($editorConfig.data.links, id: \.self) { $link in
                            HStack {
                                Text(.init("[\(link)](\(link))"))
                                    .lineLimit(1)
                                    .padding(2)
                                Spacer()
                            }
                        }
                    } else {
                        ForEach($editorConfig.data.links, id: \.self) { $link in
                            TextField("https://foo.com", text: $link)
                                .keyboardType(.URL)
                        }
                        .onDelete(perform: { indexSet in
                            editorConfig.data.links.remove(atOffsets: indexSet)
                        })
                        
                        Button(
                            action: {
                                editorConfig.data.links.append("")
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
            .navigationTitle("\(editorConfig.mode.rawValue) Operating System")
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
struct OperatingSystemItemControl_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State var testData: EditorConfig<OperatingSystem>
       
        var body: some View {
            OperatingSystemItemControl(editorConfig: $testData)
        }
    }
    
    static var previews: some View {
        Group {
            StatefulPreviewWrapper(
                testData: EditorConfig<OperatingSystem>(data: RetroCollectionItem.testData[0].operatingSystems[0], mode: .view))

            StatefulPreviewWrapper(
                testData: EditorConfig<OperatingSystem>(data: RetroCollectionItem.testData[0].operatingSystems[0], mode: .edit))
        }
    }
}
#endif
