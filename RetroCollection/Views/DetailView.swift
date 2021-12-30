//
//  DetailView.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

import SwiftUI

struct DetailView: View {
    @Binding var retroCollectionItem: RetroCollectionItem
    
    @State private var showEditView: Bool = false
    @State private var retroCollectionItemForEditing = RetroCollectionItem()
        
    @State private var driveEditorConfig: EditorConfig = EditorConfig<Drive>()
    
    var body: some View {
        
        List {
            HStack {
                Text("Manufacturer:")
                Spacer()
                Text(retroCollectionItem.manufacturer)
            }
            HStack {
                Text("Model:")
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
                    Text("CodeName:")
                    Spacer()
                    Text(retroCollectionItem.codeName ?? "")
                }
                HStack {
                    Text("Also Known As:")
                    Spacer()
                    Text(retroCollectionItem.alsoKnownAs ?? "")
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
            
            Section("Expansions") {
                ForEach (retroCollectionItem.expansions) { expansion in
                    Text(expansion.type.rawValue)
                }
            }
            
            Section("Connectors") {
                ForEach (retroCollectionItem.connections) { connection in
                    Text(connection.type.rawValue)
                }
            }
            
            OperatingSystemView(operatingSystems: $retroCollectionItem.operatingSystems)
            
            MaintenanceView(retroCollectionItem: retroCollectionItem)
            
        }
        .navigationTitle("\(retroCollectionItem.manufacturer) \(retroCollectionItem.name)")
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
        .fullScreenCover(isPresented: $showEditView, content: {
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
                                },
                                label: { Text("Save") }
                            )
                        })
                    }
                    
            }
        })
        

    }
}

struct DriveDetailsView: View {
    @Binding var show: Bool
    @Binding var drive: Drive
    
    var body: some View {
        List {
            HStack{
                Text("Manufacturer")
                Spacer()
                Text(drive.manufacturer)
            }
            
            HStack{
                Text("Model")
                Spacer()
                Text(drive.model)
            }
            
            HStack{
                Text("Size")
                Spacer()
                Text(drive.formattedSize)
            }
            
            HStack{
                Text("Working")
                Spacer()
                Text(drive.isWorking ? "Yes" : "No")
            }
        }
        
        Button("Close") { show = false }
    }
}

struct OperatingSystemView: View {
    @Binding var operatingSystems: [OperatingSystem]
    
    @State private var pop = false
    
    var body: some View {
        Section("Operating System(s)") {
        //DisclosureGroup("Maintenance") {
            ForEach (operatingSystems) { operatingSystem in
                HStack {
                    Text("\(operatingSystem.name) \(operatingSystem.version)")
                    Spacer()
                    if let url = operatingSystem.links?[0] {
                        Link("Link", destination: URL(string: url)!)
                    }
                }
            }
        }
    }
}

struct MaintenanceView: View {
    var retroCollectionItem: RetroCollectionItem
    
    var body: some View {
        Section("Maintenance") {
        //DisclosureGroup("Maintenance")  {
            HStack {
                Text("Recapped:")
                Spacer()
                //Toggle("adsf", isOn: //retroCollectionItem.maintenance?.recapped ?? false)
            }
            HStack {
                Text("Battery State:")
                Spacer()
                Text(retroCollectionItem.maintenance?.batteryState ?? "")
            }
            HStack {
                Text("Known Issues:")
                Spacer()
                Text(retroCollectionItem.maintenance?.knownIssues ?? "")
            }
            HStack() {
                Text("Note:").alignmentGuide(VerticalAlignment.top) { _ in 0 }
                //Spacer()
                Text(retroCollectionItem.maintenance?.notes ?? "")
            }
        }
    }
}

#if DEBUG
struct DetailView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var testData = RetroCollectionItem.testData[1]
        
        var body: some View {
            DetailView(retroCollectionItem: $testData)
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
