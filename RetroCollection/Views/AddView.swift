//
//  AddView.swift
//  RetroCollection
//
//  Created by JR Endean on 12/29/21.
//

import SwiftUI

struct AddView: View {
    
    @Binding var retroCollectionItem: RetroCollectionItem
    
    @State private var driveEditorConfig: EditorConfig = EditorConfig<Drive>()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Picker(
                        selection: $retroCollectionItem.type,
                        label: Text("Type")) {
                            Text("Desktop").tag("Desktop")
                            Text("Laptop").tag("Laptop")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    TextField("Manufacturer", text: $retroCollectionItem.manufacturer).disableAutocorrection(true)
                    TextField("Name", text: $retroCollectionItem.name).disableAutocorrection(true)
                    TextField("Model", text: $retroCollectionItem.model).disableAutocorrection(true)
                
                
                    Section(
                        header:
                            HStack{
                                Text("Drives")
                                Spacer()
                                Button(
                                    action: {
                                        driveEditorConfig.present(mode: .add, data: Drive())
                                    },
                                    label: { Image(systemName: "plus") })
                            },
                        content: {
                            ForEach ($retroCollectionItem.drives) { $drive in
                                HStack {
                                    Text(drive.type.rawValue)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.accentColor)
                                        .onTapGesture {
                                            driveEditorConfig.present(mode: .edit, data: drive)
                                        }
                                }
                            }
                            .sheet(
                                isPresented: $driveEditorConfig.shouldShowEdit,
                                onDismiss: {
                                    if driveEditorConfig.needsSave {
                                        let index = retroCollectionItem.drives.firstIndex(where: { $0.id == $driveEditorConfig.data.id })!
                                        retroCollectionItem.drives[index] = driveEditorConfig.data
                                    }
                                },
                                content: {
                                    DriveItemControl(editorConfig: $driveEditorConfig)
                                }
                            )
                        })
                        .sheet(
                            isPresented: $driveEditorConfig.shouldShowAdd,
                            onDismiss: {
                                if driveEditorConfig.needsSave {
                                    self.retroCollectionItem.drives.append(driveEditorConfig.data)
                                }
                            },
                            content: {
                                DriveItemControl(editorConfig: $driveEditorConfig)
                            }
                        )
                }
            }
            .navigationTitle("Create New").navigationBarTitleDisplayMode(.inline)
        }
    }
}

#if DEBUG
struct AddView_Previews: PreviewProvider {

    struct StatefulPreviewWrapper: View {
        @State private var newRetroCollectionItem: RetroCollectionItem = RetroCollectionItem()
        
        var body: some View {
            AddView(retroCollectionItem: $newRetroCollectionItem)
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




