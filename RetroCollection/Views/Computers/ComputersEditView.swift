//
//  ComputersEditView.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

import SwiftUI

struct ComputersEditView: View {
    
    @Binding var computerCollectionItem: ComputerCollectionItem
        
    @State private var driveEditorConfig: EditorConfig = EditorConfig<Drive>()
    @State private var expansionEditorConfig: EditorConfig = EditorConfig<ExpansionCard>()
    @State private var connectionEditorConfig: EditorConfig = EditorConfig<Connection>()
    @State private var operatingSystemEditorConfig: EditorConfig = EditorConfig<OperatingSystem>()
    
    @State private var imagePickerEditorConfig: EditorConfig = EditorConfig<UIImage>();
    @State private var showAddPictureChoices: Bool = false
    @State private var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary

    
    var body: some View {
                 
        Form {
            
            Section("General") {
                Picker(
                    selection: $computerCollectionItem.type,
                    label: Text("Type")) {
                        Text("Desktop").tag("Desktop")
                        Text("Laptop").tag("Laptop")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                
                HStack {
                    Text("Manufacturer:")
                    Spacer()
                    TextField("Manufacturer", text: $computerCollectionItem.manufacturer)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Name:")
                    Spacer()
                    TextField("Name", text: $computerCollectionItem.name)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Model:")
                    Spacer()
                    TextField("Model", text: $computerCollectionItem.model)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.trailing)
                }
          
                DisclosureGroup("Details") {
                    HStack {
                        Text("Model Number:")
                        Spacer()
                        TextField("Model Number", text: $computerCollectionItem.modelNumber)
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Serial Number:")
                        Spacer()
                        TextField("Serial Number", text: $computerCollectionItem.serialNumber)
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("CodeName:")
                        Spacer()
                        TextField("CodeName", text: $computerCollectionItem.codeName)
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Also Known As:")
                        Spacer()
                        TextField("Also Known As", text: $computerCollectionItem.alsoKnownAs)
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    DatePicker(
                        "Released",
                        selection:$computerCollectionItem.releasedDate,
                        displayedComponents: .date)
                        .datePickerStyle(.compact)
                    
                    DatePicker(
                        "Discontinued",
                        selection:$computerCollectionItem.discontinuedDate,
                        displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
            }
            
            
            
            Section(
                header:
                    HStack {
                        Text("Photos")
                        Spacer()
                        Button(
                            action: {
                                showAddPictureChoices = true
                            },
                            label: { Image(systemName: "plus") })
                    },
                content: {
                    ScrollView(.horizontal) {
                        HStack {
                            if computerCollectionItem.photos.isEmpty {
                                Text("None")
                            }
                            else {
                                
                                ForEach($computerCollectionItem.photos) { $photo in
                                    if (!photo.shouldDelete) {
                                        ZStack(alignment: .bottom) {
                                            //let image = DataManager.loadImage(filename: photo.id.uuidString)
                                            let imageData = $photo.image.imageData
                                        
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
                                            
                                            HStack {
                                                DefaultButton(photo: $photo, retroCollectionItem: $computerCollectionItem)
                                                /*
                                                Button(action: {
                                                    for i in retroCollectionItem.photos.indices {
                                                        retroCollectionItem.photos[i].defaultImage = false
                                                    }
                                                    //photo.defaultImage = true
                                                    
                                                    //photo.shouldDefault = true
                                                }, label: {
                                                    if photo.defaultImage {
                                                        Text(Image(systemName: "bookmark.circle.fill")).font(.title)
                                                    } else {
                                                        Text(Image(systemName: "bookmark.circle")).font(.title)
                                                    }
                                                })
                                                .padding(3)
                                                .background(Color.white)
                                                .foregroundColor(.accentColor)
                                                .clipShape(Circle())
                                                .shadow(radius: 5)
                                                */
                                                
                                                Button(action: {
                                                    //let index = retroCollectionItem.photos.firstIndex(where: { $0.id == photo.id })
                                                    //DataManager.deleteImage(filename: photo.id.uuidString)
                                                    //retroCollectionItem.photos.remove(at: index!)
                                                    photo.shouldDelete = true
                                                }, label: {
                                                    Text(Image(systemName: "trash.circle"))
                                                        .font(.title)
                                                })
                                                .padding(3)
                                                .background(Color.white)
                                                .foregroundColor(.accentColor)
                                                .clipShape(Circle())
                                                .shadow(radius: 5)
                                            }.padding([.bottom], 10)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .sheet(
                        isPresented: $imagePickerEditorConfig.shouldShowAdd,
                        onDismiss: {
                            if imagePickerEditorConfig.needsSave {
                                let photo = Photo(image: ImageWrapper(image: imagePickerEditorConfig.data), saved: false)
                                //DataManager.saveImage(filename: photo.id.uuidString, image: imagePickerEditorConfig.data)
                                computerCollectionItem.photos.append(photo)
                            }
                        },
                        content: {
                            ImagePicker(sourceType: imagePickerSourceType, editorConfig: $imagePickerEditorConfig)
                        }
                    )
                    .confirmationDialog(
                        "Add picture",
                        isPresented: $showAddPictureChoices) {
                            Button("Camera"){
                                imagePickerSourceType = .camera
                                imagePickerEditorConfig.present(mode: .add, data: UIImage())
                            }
                            
                            Button("Library") {
                                imagePickerSourceType = .photoLibrary
                                imagePickerEditorConfig.present(mode: .add, data: UIImage())
                            }
                        }
                }
            )
                
            
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
                    List {
                        ForEach ($computerCollectionItem.drives) { $drive in
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
                            computerCollectionItem.drives.remove(atOffsets: indexSet)
                        })
                        .sheet(
                            isPresented: $driveEditorConfig.shouldShowEdit,
                            onDismiss: {
                                if driveEditorConfig.needsSave {
                                    let index = computerCollectionItem.drives.firstIndex(where: { $0.id == $driveEditorConfig.data.id })!
                                    computerCollectionItem.drives[index] = driveEditorConfig.data
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
                            self.computerCollectionItem.drives.append(driveEditorConfig.data)
                        }
                    },
                    content: {
                        DriveItemControl(editorConfig: $driveEditorConfig)
                    }
                )
            
            
            Section(
                header:
                    HStack {
                        Text("Expansion")
                        Spacer()
                        Button(
                            action: {
                                expansionEditorConfig.present(mode: .add, data: ExpansionCard())
                            },
                            label: { Image(systemName: "plus") })
                    },
                content: {
                    List {
                        ForEach ($computerCollectionItem.expansions) { $expansion in
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
                            computerCollectionItem.expansions.remove(atOffsets: indexSet)
                        })
                        .sheet(
                            isPresented: $expansionEditorConfig.shouldShowEdit,
                            onDismiss: {
                                if expansionEditorConfig.needsSave {
                                    let index = computerCollectionItem.expansions.firstIndex(where: { $0.id == $expansionEditorConfig.data.id })!
                                    computerCollectionItem.expansions[index] = expansionEditorConfig.data
                                }
                            },
                            content: {
                                ExpansionItemControl(editorConfig: $expansionEditorConfig)
                            }
                        )
                    }
                })
                .sheet(
                    isPresented: $expansionEditorConfig.shouldShowAdd,
                    onDismiss: {
                        if expansionEditorConfig.needsSave {
                            self.computerCollectionItem.expansions.append(expansionEditorConfig.data)
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
                    List {
                        ForEach ($computerCollectionItem.connections) { $connection in
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
                            computerCollectionItem.connections.remove(atOffsets: indexSet)
                        })
                        .sheet(
                            isPresented: $connectionEditorConfig.shouldShowEdit,
                            onDismiss: {
                                if connectionEditorConfig.needsSave {
                                    let index = computerCollectionItem.connections.firstIndex(where: { $0.id == $connectionEditorConfig.data.id })!
                                    computerCollectionItem.connections[index] = connectionEditorConfig.data
                                }
                            },
                            content: {
                                ConnectionItemControl(editorConfig: $connectionEditorConfig)
                            }
                        )
                    }
                })
                .sheet(
                    isPresented: $connectionEditorConfig.shouldShowAdd,
                    onDismiss: {
                        if connectionEditorConfig.needsSave {
                            self.computerCollectionItem.connections.append(connectionEditorConfig.data)
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
                    ForEach ($computerCollectionItem.operatingSystems) { $operatingSystem in
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
                        computerCollectionItem.operatingSystems.remove(atOffsets: indexSet)
                    })
                    .sheet(
                        isPresented: $operatingSystemEditorConfig.shouldShowEdit,
                        onDismiss: {
                            if operatingSystemEditorConfig.needsSave {
                                let index = computerCollectionItem.operatingSystems.firstIndex(where: { $0.id == $operatingSystemEditorConfig.data.id })!
                                computerCollectionItem.operatingSystems[index] = operatingSystemEditorConfig.data
                            }
                        },
                        content: {
                            OperatingSystemItemControl(editorConfig: $operatingSystemEditorConfig)
                        }
                    )
                })
                .sheet(
                    isPresented: $operatingSystemEditorConfig.shouldShowAdd,
                    onDismiss: {
                         if operatingSystemEditorConfig.needsSave {
                            self.computerCollectionItem.operatingSystems.append(operatingSystemEditorConfig.data)
                        }
                    },
                    content: {
                        OperatingSystemItemControl(editorConfig: $operatingSystemEditorConfig)
                    }
                )
            
            
            DisclosureGroup("Links") {
                ForEach($computerCollectionItem.links, id: \.self) { $link in
                    TextField("https://foo.com", text: $link)
                        .keyboardType(.URL)
                }
                .onDelete(perform: { indexSet in
                    computerCollectionItem.links.remove(atOffsets: indexSet)
                })
            }
            
            Section(
                header:
                    HStack {
                        Text("Links")
                        Spacer()
                        Button(
                            action: {
                                computerCollectionItem.links.append("")
                            },
                            label: { Image(systemName: "plus") })
                    },
                content: {
                    ForEach($computerCollectionItem.links, id: \.self) { $link in
                        TextField("https://foo.com", text: $link)
                            .keyboardType(.URL)
                    }
                    .onDelete(perform: { indexSet in
                        computerCollectionItem.links.remove(atOffsets: indexSet)
                    })
                }
            )
            
            
            DisclosureGroup("Maintenance") {
                Toggle("Recapped:", isOn: $computerCollectionItem.maintenance.recapped)
                
                HStack {
                    Text("Battery State:")
                    Spacer()
                    TextField("Battery State", text: $computerCollectionItem.maintenance.batteryState)
                }
                
                HStack {
                    Text("Known Issues:")
                    Spacer()
                    TextField("Known Issues", text: $computerCollectionItem.maintenance.knownIssues)
                }

                HStack {
                    Text("Notes:")
                    Spacer()
                    TextField("Notes", text: $computerCollectionItem.maintenance.notes)
                }
            }
            
        }
        .navigationTitle("\(computerCollectionItem.manufacturer) \(computerCollectionItem.name)")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

#if DEBUG
struct EditView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var item = ComputerCollectionItem.testData[0]
        
        var body: some View {
            ComputersEditView(computerCollectionItem: $item)
        }
    }
    
    static var previews: some View {
        NavigationView {
            StatefulPreviewWrapper()
        }
    }
}
#endif
