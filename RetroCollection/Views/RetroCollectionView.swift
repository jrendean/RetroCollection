//
//  ContentView.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

// https://blckbirds.com/post/side-menu-hamburger-menu-in-swiftui/


import SwiftUI

struct RetroCollectionView: View {
    
    @Binding var computerCollectionItems: [ComputerCollectionItem]
    @Binding var componentCollectionItems: [ComponentCollectionItem]
    @Binding var gamingCollectionItems: [GamingCollectionItem]
    
    @State var newComputerCollectionItem: ComputerCollectionItem = ComputerCollectionItem()
    @State var newComponentCollectionItem: ComponentCollectionItem = ComponentCollectionItem()
    @State var newGamingCollectionItem: GamingCollectionItem = GamingCollectionItem()
    
    @State var showMenu: Bool = false
    @State var whichView: String = "computer"
    
    @State var searchText: String
    
    @State var showAddView: Bool = false
    
    var body: some View {

        NavigationView {
            
            GeometryReader { geometry in
                
                ZStack(alignment: .leading) {
                    
                    // TODO: make enum
                    switch whichView {
                    case "computer":
                        ComputersCollectionView(computerCollectionItems: self.$computerCollectionItems, searchText: searchText)
                    
                    case "component":
                        ComponentsCollectionView(componentCollectionItems: self.$componentCollectionItems, searchText: searchText)
                        
                    case "gaming":
                        GamingCollectionView(gamingCollectionItems: self.$gamingCollectionItems, searchText: searchText)

                    default:
                        ComputersCollectionView(computerCollectionItems: self.$computerCollectionItems, searchText: searchText)
                    }
                    
                    if self.showMenu {
                        MenuView(showMenu: $showMenu, whichView: $whichView)
                            .frame(width: geometry.size.width / 2)
                            .transition(.move(edge: .leading))
                            .zIndex(900)
                    }
                }
                .gesture(DragGesture()
                    .onEnded {
                        if $0.translation.width < -100 {
                            withAnimation {
                                self.showMenu = false
                            }
                        }
                    }
                )
            }
            //.searchable(text: $searchText)
            .navigationTitle("Retro Collection")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading, content: {
                    if !showMenu {
                        Button(
                            action: {
                                withAnimation {
                                    self.showMenu.toggle()
                                }
                            },
                            label: { Image(systemName: "line.horizontal.3") }
                        )
                    }
                })
                
                #if DEBUG
                ToolbarItem(
                    placement: .navigationBarLeading,
                    content: {
                        if !showMenu {
                            Button(
                                action: {
                                    DataManager.saveComputersCollection(computerCollectionItems: ComputerCollectionItem.testData)
                                    DataManager.loadComputersCollection { computerCollectionItems in
                                        self.computerCollectionItems = computerCollectionItems
                                    }
                                    
                                    DataManager.saveComponentsCollection(componentsCollectionItems: ComponentCollectionItem.testData)
                                    DataManager.loadComponentsCollection { componentCollectionItems in
                                        self.componentCollectionItems = componentCollectionItems
                                    }
                                    
                                    DataManager.saveGamingCollection(gamingCollectionItems: GamingCollectionItem.testData)
                                    DataManager.loadGamingCollection { gamingCollectionItems in
                                        self.gamingCollectionItems = gamingCollectionItems
                                    }
                                },
                                label: {
                                    Text("T")
                                }
                            )
                        }
                    })
                #endif
                
                //ToolbarItem(placement: .navigationBarTrailing, content: { EditButton() })
                
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    if !showMenu {
                        EditButton()
                    }
                })
                
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    if !showMenu {
                        Button(
                            action: {
                                self.showAddView = true
                            },
                            label: {
                                Image(systemName: "plus")
                            }
                        )
                    }
                })

            }
            .fullScreenCover(
                isPresented: $showAddView,
                content: {
                    NavigationView {
                        // TODO: make enum
                        switch whichView {
                        case "computer":
                            getComputerAddView()
                        
                        case "component":
                            getComponentAddView()
                            
                        case "gaming":
                            getGamingAddView()

                        default:
                            getComputerAddView()
                        }
                    }
                })
        }
        .searchable(text: $searchText)
    }
    
    func getComputerAddView() -> AnyView {
        return AnyView(
            ComputersAddView(computerCollectionItem: $newComputerCollectionItem)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction, content: {
                        Button(
                            action: {
                                showAddView = false
                                
                                // delete the copied photos that are not saved
                                //for photo in newRetroCollectionItem.photos {
                                //    if !photo.saved {
                                //        //DataManager.deleteImage(filename: photo.id.uuidString)
                                //    }
                                //}
                                
                                // reset the object
                                newComputerCollectionItem = ComputerCollectionItem()
                            },
                            label: { Text("Cancel") }
                        )
                    })
                    
                    ToolbarItem(placement: .confirmationAction, content: {
                        Button(
                            action: {
                                showAddView = false
                                
                                self.computerCollectionItems.append(newComputerCollectionItem)
                                
                                newComputerCollectionItem = ComputerCollectionItem()
                                
                                //DataManager.save(retroCollectionItems: self.retroCollectionItems)
                            },
                            label: { Text("Save") }
                        )
                        .disabled(!newComputerCollectionItem.validView)
                    })
                }
        )
    }
    
    func getComponentAddView() -> AnyView {
        return AnyView(
            ComponentsAddView(componentCollectionItem: $newComponentCollectionItem)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction, content: {
                        Button(
                            action: {
                                showAddView = false
                                
                                // delete the copied photos that are not saved
                                //for photo in newRetroCollectionItem.photos {
                                //    if !photo.saved {
                                //        //DataManager.deleteImage(filename: photo.id.uuidString)
                                //    }
                                //}
                                
                                // reset the object
                                newComponentCollectionItem = ComponentCollectionItem()
                            },
                            label: { Text("Cancel") }
                        )
                    })
                    
                    ToolbarItem(placement: .confirmationAction, content: {
                        Button(
                            action: {
                                showAddView = false
                                
                                self.componentCollectionItems.append(newComponentCollectionItem)
                                
                                newComponentCollectionItem = ComponentCollectionItem()
                                
                                //DataManager.save(retroCollectionItems: self.retroCollectionItems)
                            },
                            label: { Text("Save") }
                        )
                        .disabled(!newComponentCollectionItem.validView)
                    })
                }
        )
    }
    
    func getGamingAddView() -> AnyView {
        return AnyView(
            GamingAddView(gamingCollectionItem: $newGamingCollectionItem)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction, content: {
                        Button(
                            action: {
                                showAddView = false
                                
                                // delete the copied photos that are not saved
                                //for photo in newRetroCollectionItem.photos {
                                //    if !photo.saved {
                                //        //DataManager.deleteImage(filename: photo.id.uuidString)
                                //    }
                                //}
                                
                                // reset the object
                                newGamingCollectionItem = GamingCollectionItem()
                            },
                            label: { Text("Cancel") }
                        )
                    })
                    
                    ToolbarItem(placement: .confirmationAction, content: {
                        Button(
                            action: {
                                showAddView = false
                                
                                self.gamingCollectionItems.append(newGamingCollectionItem)
                                
                                newGamingCollectionItem = GamingCollectionItem()
                                
                                //DataManager.save(retroCollectionItems: self.retroCollectionItems)
                            },
                            label: { Text("Save") }
                        )
                        .disabled(!newGamingCollectionItem.validView)
                    })
                }
        )
    }
}





struct MenuView: View {
    
    @Binding var showMenu: Bool
    @Binding var whichView: String
    
    var body: some View {
        VStack(alignment: .leading) {

            Button(
                action: {
                    whichView = "computer"
                    showMenu = false
                },
                label: {
                    Image(systemName: "pc")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Computers")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            ).padding(.top, 100)
                       
            Button(
                action: {
                    whichView = "component"
                    showMenu = false
                },
                label:{
                    Image(systemName: "memorychip")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Components")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            ).padding(.top, 20)
            
            Button(
                action: {
                    whichView = "gaming"
                    showMenu = false
                },
                label: {
                    Image(systemName: "gamecontroller")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Gaming")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            ).padding(.top, 20)

            Spacer()
            
            HStack(alignment: .bottom) {
                Image(systemName: "gearshape")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Settings")
                    .foregroundColor(.gray)
                    .font(.headline)
            }.padding(.bottom, 30)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.black)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture { showMenu = false }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var computerTestData = ComputerCollectionItem.testData
        @State private var componentTestData = ComponentCollectionItem.testData
        @State private var gamingTestData = GamingCollectionItem.testData
        
        var body: some View {
            RetroCollectionView(computerCollectionItems: $computerTestData, componentCollectionItems: $componentTestData, gamingCollectionItems: $gamingTestData, searchText: "")
        }
    }
    
    static var previews: some View {
         
        Group {
            StatefulPreviewWrapper()
        
            StatefulPreviewWrapper()
                .preferredColorScheme(.dark)
        }
    }
}
#endif
