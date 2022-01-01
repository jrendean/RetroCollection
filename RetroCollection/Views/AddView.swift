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
    @State private var expansionEditorConfig: EditorConfig = EditorConfig<ExpansionCard>()
    @State private var connectionEditorConfig: EditorConfig = EditorConfig<Connection>()
    @State private var operatingSystemEditorConfig: EditorConfig = EditorConfig<OperatingSystem>()
    
    var body: some View {
            
        Form {
            
            Section("General") {
                Picker(
                    selection: $retroCollectionItem.type,
                    label: Text("Type")) {
                        Text("Desktop").tag("Desktop")
                        Text("Laptop").tag("Laptop")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                
                TextField("Manufacturer", text: $retroCollectionItem.manufacturer)
                
                TextField("Name", text: $retroCollectionItem.name)
                    .disableAutocorrection(true)
                
                TextField("Model", text: $retroCollectionItem.model)
                    .disableAutocorrection(true)
            
                DisclosureGroup("Details") {
                    
                    TextField("Model Number", text: $retroCollectionItem.modelNumber)
                        .disableAutocorrection(true)
                    
                    TextField("Serial Number", text: $retroCollectionItem.serialNumber)
                        .disableAutocorrection(true)
                    
                    TextField("CodeName", text: $retroCollectionItem.codeName)
                        .disableAutocorrection(true)
                    
                    TextField("Also Known As", text: $retroCollectionItem.alsoKnownAs)
                        .disableAutocorrection(true)
                
                    DatePicker(
                        "Released",
                        selection:$retroCollectionItem.releasedDate,
                        displayedComponents: .date)
                        .datePickerStyle(.compact)
                    
                    DatePicker(
                        "Discontinued",
                        selection:$retroCollectionItem.discontinuedDate,
                        displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
            }
            
            Section(
                header:
                    HStack {
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
                    .onDelete(perform: { indexSet in
                        retroCollectionItem.drives.remove(atOffsets: indexSet)
                    })
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
            
            
            Section(
                header:
                    HStack {
                        Text("Expansions")
                        Spacer()
                        Button(
                            action: {
                                expansionEditorConfig.present(mode: .add, data: ExpansionCard())
                            },
                            label: { Image(systemName: "plus") })
                    },
                content: {
                    ForEach ($retroCollectionItem.expansions) { $expansion in
                        HStack {
                            Text(expansion.type.rawValue)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.accentColor)
                                .onTapGesture {
                                    expansionEditorConfig.present(mode: .edit, data: expansion)
                                }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        retroCollectionItem.expansions.remove(atOffsets: indexSet)
                    })
                    .sheet(
                        isPresented: $expansionEditorConfig.shouldShowEdit,
                        onDismiss: {
                            if expansionEditorConfig.needsSave {
                                let index = retroCollectionItem.expansions.firstIndex(where: { $0.id == $expansionEditorConfig.data.id })!
                                retroCollectionItem.expansions[index] = expansionEditorConfig.data
                            }
                        },
                        content: {
                            ExpansionItemControl(editorConfig: $expansionEditorConfig)
                        }
                    )
                })
                .sheet(
                    isPresented: $expansionEditorConfig.shouldShowAdd,
                    onDismiss: {
                        if expansionEditorConfig.needsSave {
                            self.retroCollectionItem.expansions.append(expansionEditorConfig.data)
                        }
                    },
                    content: {
                        ExpansionItemControl(editorConfig: $expansionEditorConfig)
                    }
                )
            
            
            Section(
                header:
                    HStack {
                        Text("Connections")
                        Spacer()
                        Button(
                            action: {
                                connectionEditorConfig.present(mode: .add, data: Connection())
                            },
                            label: { Image(systemName: "plus") })
                    },
                content: {
                    ForEach ($retroCollectionItem.connections) { $connection in
                        HStack {
                            Text(connection.type.rawValue)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.accentColor)
                                .onTapGesture {
                                    connectionEditorConfig.present(mode: .edit, data: connection)
                                }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        retroCollectionItem.connections.remove(atOffsets: indexSet)
                    })
                    .sheet(
                        isPresented: $connectionEditorConfig.shouldShowEdit,
                        onDismiss: {
                            if connectionEditorConfig.needsSave {
                                let index = retroCollectionItem.connections.firstIndex(where: { $0.id == $connectionEditorConfig.data.id })!
                                retroCollectionItem.connections[index] = connectionEditorConfig.data
                            }
                        },
                        content: {
                            ConnectionItemControl(editorConfig: $connectionEditorConfig)
                        }
                    )
                })
                .sheet(
                    isPresented: $connectionEditorConfig.shouldShowAdd,
                    onDismiss: {
                        if connectionEditorConfig.needsSave {
                            self.retroCollectionItem.connections.append(connectionEditorConfig.data)
                        }
                    },
                    content: {
                        ConnectionItemControl(editorConfig: $connectionEditorConfig)
                    }
                )
           

            Section(
                header:
                    HStack {
                        Text("Operating System(s)")
                        Spacer()
                        Button(
                            action: {
                                operatingSystemEditorConfig.present(mode: .add, data: OperatingSystem())
                            },
                            label: { Image(systemName: "plus") })
                    },
                content: {
                    ForEach ($retroCollectionItem.operatingSystems) { $operatingSystem in
                        HStack {
                            Text("\(operatingSystem.name) \(operatingSystem.version)")
                            Spacer()
                            if (operatingSystem.links.count > 0) {
                                Link(destination: URL(string: operatingSystem.links[0])!) {
                                    Image(systemName: "info.circle")
                                        .symbolRenderingMode(.multicolor)
                                }
                            }
                            Image(systemName: "chevron.right")
                                .foregroundColor(.accentColor)
                                .onTapGesture {
                                    operatingSystemEditorConfig.present(mode: .edit, data: operatingSystem)
                                }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        retroCollectionItem.operatingSystems.remove(atOffsets: indexSet)
                    })
                })
                .sheet(
                    isPresented: $operatingSystemEditorConfig.shouldShowAdd,
                    onDismiss: {
                         if operatingSystemEditorConfig.needsSave {
                            self.retroCollectionItem.operatingSystems.append(operatingSystemEditorConfig.data)
                        }
                    },
                    content: {
                        OperatingSystemItemControl(editorConfig: $operatingSystemEditorConfig)
                    }
                )
            

            Section(
                header:
                    HStack {
                        Text("Links")
                        Spacer()
                        Button(
                            action: {
                                retroCollectionItem.links.append("")
                            },
                            label: { Image(systemName: "plus") })
                    },
                content: {
                    ForEach($retroCollectionItem.links, id: \.self) { $link in
                        TextField("https://foo.com", text: $link)
                            .keyboardType(.URL)
                    }
                    .onDelete(perform: { indexSet in
                        retroCollectionItem.links.remove(atOffsets: indexSet)
                    })
                    
                }
            )
            
            
            DisclosureGroup("Maintenance") {
                Toggle("Recapped:", isOn: $retroCollectionItem.maintenance.recapped)
                
                HStack {
                    Text("Battery State:")
                    Spacer()
                    TextField("Battery State", text: $retroCollectionItem.maintenance.batteryState)
                }
                
                HStack {
                    Text("Known Issues:")
                    Spacer()
                    TextField("Known Issues", text: $retroCollectionItem.maintenance.knownIssues)
                }

                HStack {
                    Text("Notes:")
                    Spacer()
                    TextField("Notes", text: $retroCollectionItem.maintenance.notes)
                }
            }
            
            
        }
        .navigationTitle("Create New")
        .navigationBarTitleDisplayMode(.inline)
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
