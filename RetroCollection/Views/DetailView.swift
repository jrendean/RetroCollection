//
//  DetailView.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var retroCollectionItems: [RetroCollectionItem]
    @Binding var retroCollectionItem: RetroCollectionItem
    
    @State private var showEditView: Bool = false
    @State private var retroCollectionItemForEditing = RetroCollectionItem()
        
    @State private var driveEditorConfig: EditorConfig = EditorConfig<Drive>()
    @State private var expansionEditorConfig: EditorConfig = EditorConfig<ExpansionCard>()
    @State private var connectionEditorConfig: EditorConfig = EditorConfig<Connection>()
    
    var body: some View {
        
        List {
            
            Section("General") {
                
                HStack {
                    Text("Type:")
                    Spacer()
                    Text(retroCollectionItem.type)
                }
                
                HStack {
                    Text("Manufacturer:")
                    Spacer()
                    Text(retroCollectionItem.manufacturer)
                }
                
                HStack {
                    Text("Name:")
                    Spacer()
                    Text(retroCollectionItem.name)
                }
                
                HStack {
                    Text("Processor")
                    Spacer()
                    Text(retroCollectionItem.processorInfo)
                }
                
                HStack {
                    Text("Total RAM")
                    Spacer()
                    Text(retroCollectionItem.totalRam)
                }
          
                DisclosureGroup("Details") {
                    
                    HStack {
                        Text("Model:")
                        Spacer()
                        Text(retroCollectionItem.model)
                    }
                    
                    HStack {
                        Text("Model Number:")
                        Spacer()
                        Text(retroCollectionItem.modelNumber)
                    }
                    
                    HStack {
                        Text("Serial Number:")
                        Spacer()
                        Text(retroCollectionItem.serialNumber)
                    }
                    
                    HStack {
                        Text("CodeName:")
                        Spacer()
                        Text(retroCollectionItem.codeName)
                    }
                    
                    HStack {
                        Text("Also Known As:")
                        Spacer()
                        Text(retroCollectionItem.alsoKnownAs)
                    }
                    
                    HStack {
                        Text("Released:")
                        Spacer()
                        Text(retroCollectionItem.releasedDateFormatted)
                    }
                    
                    HStack {
                        Text("Discontinued:")
                        Spacer()
                        Text(retroCollectionItem.discontinuedDateFormatted)
                    }
                }
            }
            
            
            Section("Drives") {
                ForEach ($retroCollectionItem.drives) { $drive in
                    HStack {
                        Text(drive.type.rawValue)
                        Spacer()
                        Image(systemName: "info.circle")
                            .symbolRenderingMode(.multicolor)
                            .onTapGesture {
                                driveEditorConfig.present(mode: .view, data: drive)
                            }
                    }
                }
                .sheet(
                    isPresented: $driveEditorConfig.shouldShowView,
                    content: {
                        DriveItemControl(editorConfig: $driveEditorConfig)
                    }
                )
            }
            
            Section("Expansion") {
                ForEach ($retroCollectionItem.expansions) { $expansion in
                    HStack {
                        Text(expansion.type.rawValue)
                        Spacer()
                        Image(systemName: "info.circle")
                            .symbolRenderingMode(.multicolor)
                            .onTapGesture {
                                expansionEditorConfig.present(mode: .view, data: expansion)
                            }
                    }
                }
                .sheet(
                    isPresented: $expansionEditorConfig.shouldShowView,
                    content: {
                        ExpansionItemControl(editorConfig: $expansionEditorConfig)
                    }
                )
            }
            
            Section("Connections") {
                ForEach ($retroCollectionItem.connections) { $connection in
                    HStack {
                        Text(connection.type.rawValue)
                        Spacer()
                        Image(systemName: "info.circle")
                            .symbolRenderingMode(.multicolor)
                            .onTapGesture {
                                connectionEditorConfig.present(mode: .view, data: connection)
                            }
                    }
                }
                .sheet(
                    isPresented: $connectionEditorConfig.shouldShowView,
                    content: {
                        ConnectionItemControl(editorConfig: $connectionEditorConfig)
                    }
                )
            }
            
            
            Section("Operating System(s)") {
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
                    }
                }
            }
            
            
            Section("Links") {                
                ForEach($retroCollectionItem.links, id: \.self) { $link in
                    HStack {
                        Text(.init("[\(link)](\(link))"))
                            .lineLimit(1)
                            .padding(2)
                        Spacer()
                    }
                }
            }
            
            
            Section("Maintenance") {
                HStack {
                    Text("Recapped:")
                    Spacer()
                    Text(retroCollectionItem.maintenance.recapped ? "Yes" : "No")
                }
                HStack {
                    Text("Battery State:")
                    Spacer()
                    Text(retroCollectionItem.maintenance.batteryState)
                }
                HStack {
                    Text("Known Issues:")
                    Spacer()
                    Text(retroCollectionItem.maintenance.knownIssues)
                }
                HStack() {
                    Text("Note:")
                    Spacer()
                    Text(retroCollectionItem.maintenance.notes)
                }
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(
                    action: {
                        showEditView = true
                        retroCollectionItemForEditing = self.retroCollectionItem
                    },
                    label: { Text("Edit") })
            })
        }
        .fullScreenCover(
            isPresented: $showEditView,
            content: {
                NavigationView {
                    EditView(retroCollectionItem: $retroCollectionItemForEditing)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction, content: {
                                Button(
                                    action: { showEditView = false },
                                    label: { Text("Cancel") }
                                )
                            })
                            
                            ToolbarItem(placement: .confirmationAction, content: {
                                Button(
                                    action: {
                                        showEditView = false
                                        
                                        self.retroCollectionItem = retroCollectionItemForEditing
                                        
                                        // HACK with passing in the binding for all the whole collection and just this item, fix me
                                        // perhaps do no use a navigationlink in the main view and do a sheet or ontap thing that has
                                        // ondismiss or use editorconfig and pass that in
                                        // or anoter datamanager.save() that takes the single item, finds it, updates it
                                        // then calls the regular save
                                        DataManager.save(retroCollectionItems: self.retroCollectionItems)
                                    },
                                    label: { Text("Save") }
                                )
                            })
                        }                        
                }
            })
        .navigationTitle("\(retroCollectionItem.manufacturer) \(retroCollectionItem.name)")
        
    }
}


#if DEBUG
struct DetailView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        
        @State private var testData1 = RetroCollectionItem.testData
        @State private var testData2 = RetroCollectionItem.testData[0]
        
        var body: some View {
            DetailView(retroCollectionItems: $testData1, retroCollectionItem: $testData2)
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
