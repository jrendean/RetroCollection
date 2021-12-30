//
//  EditView.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

import SwiftUI

struct EditView: View {
    
    @Binding var retroCollectionItem: RetroCollectionItem
        
    @State private var driveEditorConfig: EditorConfig = EditorConfig<Drive>()
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            
            Form {
                Section("General") {
                    TextField("Manufacturer", text: $retroCollectionItem.manufacturer)
                    TextField("Name", text: $retroCollectionItem.name)
                    TextField("Model", text: $retroCollectionItem.model)
              
                    DisclosureGroup("Details") {
                        TextField("Model Number", text: $retroCollectionItem.modelNumber)
                        //TextField("Code Name", text: $retroCollectionItem.codeName)
                        //TextField("Also Known As", text: $retroCollectionItem.alsoKnownAs)
                        //DatePicker(selection: $retroCollectionItem.releasedDate, displayedComponents: .date) {
                        //    Text("Released")
                        //}
                        //DatePicker(selection: $retroCollectionItem.discontinuedDate, displayedComponents: .date) {
                        //    Text("Discontinued")
                        //}
                    }
                }
                
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
                        List {
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
                        }
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
                
                
                Section("Expansion") {
                    
                }
                
                Section("Connectors") {
                    
                }
                
                Section("Operating Systems") {
                    
                }
                
                Section("Maintenance") {
                    
                }
            }
        
            //FloatingMenuControl().padding()
        }
    }
}

#if DEBUG
struct EditView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var testData = RetroCollectionItem.testData[1]
        
        var body: some View {
            NavigationView {
                EditView(retroCollectionItem: $testData)
            }
        }
    }
    
    static var previews: some View {
        StatefulPreviewWrapper()
    }
}
#endif
