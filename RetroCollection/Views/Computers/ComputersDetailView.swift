//
//  ComputersDetailView.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

import SwiftUI

struct ComputersDetailView: View {
    
    @Binding var computerCollectionItems: [ComputerCollectionItem]
    @Binding var computerCollectionItem: ComputerCollectionItem
    
    @State private var showEditView: Bool = false
    @State private var computerCollectionItemForEditing = ComputerCollectionItem()
        
    @State private var driveEditorConfig: EditorConfig = EditorConfig<Drive>()
    @State private var expansionEditorConfig: EditorConfig = EditorConfig<ExpansionCard>()
    @State private var connectionEditorConfig: EditorConfig = EditorConfig<Connection>()
    
    var body: some View {
        
        List {
            
            Section("General") {
                
                HStack {
                    Text("Type:")
                    Spacer()
                    Text(computerCollectionItem.type)
                }
                
                HStack {
                    Text("Manufacturer:")
                    Spacer()
                    Text(computerCollectionItem.manufacturer)
                }
                
                HStack {
                    Text("Name:")
                    Spacer()
                    Text(computerCollectionItem.name)
                }
                
                HStack {
                    Text("Processor")
                    Spacer()
                    Text(computerCollectionItem.processorInfo)
                }
                
                HStack {
                    Text("Total RAM")
                    Spacer()
                    Text(computerCollectionItem.totalRam)
                }
          
                DisclosureGroup("Details") {
                    
                    HStack {
                        Text("Model:")
                        Spacer()
                        Text(computerCollectionItem.model)
                    }
                    
                    HStack {
                        Text("Model Number:")
                        Spacer()
                        Text(computerCollectionItem.modelNumber)
                    }
                    
                    HStack {
                        Text("Serial Number:")
                        Spacer()
                        Text(computerCollectionItem.serialNumber)
                    }
                    
                    HStack {
                        Text("CodeName:")
                        Spacer()
                        Text(computerCollectionItem.codeName)
                    }
                    
                    HStack {
                        Text("Also Known As:")
                        Spacer()
                        Text(computerCollectionItem.alsoKnownAs)
                    }
                    
                    HStack {
                        Text("Released:")
                        Spacer()
                        Text(computerCollectionItem.releasedDateFormatted)
                    }
                    
                    HStack {
                        Text("Discontinued:")
                        Spacer()
                        Text(computerCollectionItem.discontinuedDateFormatted)
                    }
                }
            }
            
            
            Section("Photos") {
                ScrollView(.horizontal) {
                    HStack {
                        if computerCollectionItem.photos.isEmpty {
                            Text("None")
                        }
                        else {
                            ForEach($computerCollectionItem.photos) { photo in
                                //let image = DataManager.loadImage(filename: photo.id.uuidString)
                                let imageData = photo.image.imageData
                            
                                Image.init(uiImage: UIImage(data: imageData.wrappedValue)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 360)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(radius: 5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.white, lineWidth: 5)
                                    )
                            }
                        }
                    }
                }
            }
            
            
            Section("Drives") {
                ForEach ($computerCollectionItem.drives) { $drive in
                    HStack {
                        Text(drive.type.rawValue)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.accentColor)
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
                ForEach ($computerCollectionItem.expansions) { $expansion in
                    HStack {
                        Text(expansion.type.rawValue)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.accentColor)
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
                ForEach ($computerCollectionItem.connections) { $connection in
                    HStack {
                        Text(connection.type.rawValue)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.accentColor)
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
                ForEach ($computerCollectionItem.operatingSystems) { $operatingSystem in
                    HStack {
                        Text("\(operatingSystem.name) \(operatingSystem.version)")
                        Spacer()
                        if (operatingSystem.links.count > 0) {
                            Link(destination: URL(string: operatingSystem.links[0])!) {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                }
            }
            
            
            Section("Links") {                
                ForEach($computerCollectionItem.links, id: \.self) { $link in
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
                    Text(computerCollectionItem.maintenance.recapped ? "Yes" : "No")
                }
                HStack {
                    Text("Battery State:")
                    Spacer()
                    Text(computerCollectionItem.maintenance.batteryState)
                }
                HStack {
                    Text("Known Issues:")
                    Spacer()
                    Text(computerCollectionItem.maintenance.knownIssues)
                }
                HStack() {
                    Text("Note:")
                    Spacer()
                    Text(computerCollectionItem.maintenance.notes)
                }
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(
                    action: {
                        showEditView = true
                        computerCollectionItemForEditing = self.computerCollectionItem
                    },
                    label: { Text("Edit") })
            })
        }
        .fullScreenCover(
            isPresented: $showEditView,
            content: {
                NavigationView {
                    ComputersEditView(computerCollectionItem: $computerCollectionItemForEditing)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction, content: {
                                Button(
                                    action: {
                                        showEditView = false
                                        
                                        // delete the copied photos that are not saved
                                        var toRemove: [Int] = []
                                        for i in computerCollectionItemForEditing.photos.indices {
                                            if !computerCollectionItemForEditing.photos[i].saved {
                                                toRemove.append(i)
                                            }
                                        }
                                        for i in toRemove {
                                            //DataManager.deleteImage(filename: retroCollectionItemForEditing.photos[i].id.uuidString)
                                            computerCollectionItemForEditing.photos.remove(at: i)
                                        }
                                        
                                        self.computerCollectionItem = computerCollectionItemForEditing
                                        
                                        // HACK with passing in the binding for all the whole collection and just this item, fix me
                                        // perhaps do no use a navigationlink in the main view and do a sheet or ontap thing that has
                                        // ondismiss or use editorconfig and pass that in
                                        // or anoter datamanager.save() that takes the single item, finds it, updates it
                                        // then calls the regular save
                                        DataManager.saveComputersCollection(computerCollectionItems: self.computerCollectionItems)
                                    },
                                    label: { Text("Cancel") }
                                )
                            })
                            
                            ToolbarItem(placement: .confirmationAction, content: {
                                Button(
                                    action: {
                                        showEditView = false
                                        
                                        
                                        // delete the photos that were marked to be deleted
                                        var toRemove: [Int] = []
                                        for i in computerCollectionItemForEditing.photos.indices {
                                            if computerCollectionItemForEditing.photos[i].shouldDelete {
                                                toRemove.append(i)
                                            }
                                        }
                                        for i in toRemove {
                                            //DataManager.deleteImage(filename: retroCollectionItemForEditing.photos[i].id.uuidString)
                                            computerCollectionItemForEditing.photos.remove(at: i)
                                        }
                                        
                                        
                                        
                                        self.computerCollectionItem = computerCollectionItemForEditing
                                        
                                        // HACK with passing in the binding for all the whole collection and just this item, fix me
                                        // perhaps do no use a navigationlink in the main view and do a sheet or ontap thing that has
                                        // ondismiss or use editorconfig and pass that in
                                        // or anoter datamanager.save() that takes the single item, finds it, updates it
                                        // then calls the regular save
                                        DataManager.saveComputersCollection(computerCollectionItems: self.computerCollectionItems)
                                    },
                                    label: { Text("Save") }
                                )
                                .disabled(!computerCollectionItemForEditing.validView)
                            })
                        }                        
                }
            })
        .navigationTitle("\(computerCollectionItem.manufacturer) \(computerCollectionItem.name)")
        
    }
}


#if DEBUG
struct DetailView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        
        @State private var items = ComputerCollectionItem.testData
        @State private var item = ComputerCollectionItem.testData[0]
        
        var body: some View {
            ComputersDetailView(computerCollectionItems: $items, computerCollectionItem: $item)
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
