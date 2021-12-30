//
//  ContentView.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

// https://blckbirds.com/post/side-menu-hamburger-menu-in-swiftui/


import SwiftUI

struct RetroCollectionView: View {
    
    @Binding var retroCollectionItems: [RetroCollectionItem]
    @State var newRetroCollectionItem: RetroCollectionItem = RetroCollectionItem()
    
    @State var showMenu: Bool = false
    @State var searchText: String
    
    @State var showAddView: Bool = false
    
    var body: some View {

        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    
                    MainView(retroCollectionItems: self.$retroCollectionItems, searchText: searchText)

                    if self.showMenu {
                        MenuView()
                            .frame(width: geometry.size.width / 2)
                            .transition(.move(edge: .leading))
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
            .searchable(text: $searchText)
            .navigationTitle("Retro Collection").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                /*
                 ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(
                        action: {
                            withAnimation {
                                self.showMenu.toggle()
                            }
                        },
                        label: { Image(systemName: "line.horizontal.3") }
                    )
                })
                */
                
                ToolbarItem(placement: .navigationBarTrailing, content: { EditButton() })
                
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(
                        action: {
                            self.showAddView = true
                        },
                        label: {
                            Image(systemName: "plus")
                            /*
                             NavigationLink(
                                destination: AddView(),
                                label: { Image(systemName: "plus") }
                            )
                            */
                        }
                    )
                    .disabled(self.showMenu ? true : false)
                })
            }
            .fullScreenCover(
                isPresented: $showAddView,
                content: {
                    NavigationView {
                        AddView(retroCollectionItem: $newRetroCollectionItem)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction, content: {
                                    Button(
                                        action: {
                                            showAddView = false
                                            newRetroCollectionItem = RetroCollectionItem()
                                        },
                                        label: { Text("Cancel") }
                                    )
                                })
                                
                                ToolbarItem(placement: .confirmationAction, content: {
                                    Button(
                                        action: {
                                            showAddView = false
                                            
                                            self.retroCollectionItems.append(newRetroCollectionItem)
                                            
                                            newRetroCollectionItem = RetroCollectionItem()
                                        },
                                        label: { Text("Save") }
                                    )
                                })
                            }
                        }
                })
        }
    }
}


struct MainView: View {
    
    @Binding var retroCollectionItems: [RetroCollectionItem]
    
    var searchText: String
    
    var body: some View {
        
        List {
            ForEach(retroCollectionItems.filter {
                    searchText == "" || $0.name.contains(searchText) }) { retroCollectionItem in
                
                let index = retroCollectionItems.firstIndex(where: { $0.id == retroCollectionItem.id })!
                let retroCollectionItemBinding = $retroCollectionItems[index]
                
                NavigationLink(
                    destination: DetailView(retroCollectionItem: retroCollectionItemBinding)) {
                        RetroCollectionItemRow(retroCollectionItem: retroCollectionItem)
                    }
            }
            .onDelete(perform: onDelete)
            .onMove(perform: onMove)
        }
    }
    
    func onDelete(offsets: IndexSet) {
        retroCollectionItems.remove(atOffsets: offsets)
    }
    
    func onMove(source: IndexSet, destination: Int){
        retroCollectionItems.move(fromOffsets: source, toOffset: destination)
    }
    
}


struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Profile")
                    .foregroundColor(.gray)
                    .font(.headline)
            }.padding(.top, 100)
            
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
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var testData = RetroCollectionItem.testData
        
        var body: some View {
            RetroCollectionView(retroCollectionItems: $testData, searchText: "")
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
