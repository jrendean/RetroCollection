//
//  CollectionItemRow.swift
//  RetroCatalog
//
//  Created by JR Endean on 12/26/21.
//

import SwiftUI

struct ComputersItemRow: View {
    var computerCollectionItem: ComputerCollectionItem
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                if computerCollectionItem.photos.isEmpty {
                    Image(systemName: computerCollectionItem.type == "Laptop" ? "laptopcomputer" : "desktopcomputer")
                        .symbolRenderingMode(.hierarchical)
                        .font(.largeTitle)
                        .imageScale(.large)
                } else {
                    let defaultPhoto = computerCollectionItem.photos.first(where: { $0.defaultImage })
                    //let image = DataManager.loadImage(filename: defaultPhoto == nil ? retroCollectionItem.photos[0].id.uuidString : defaultPhoto!.id.uuidString)
                    let imageData = defaultPhoto == nil ? computerCollectionItem.photos[0].image.imageData : defaultPhoto?.image.imageData
                    Image.init(uiImage: UIImage(data: imageData!)!)
                        .resizable()
                        .frame(width: 75, height: 75, alignment: .center)
                }
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("\(computerCollectionItem.manufacturer) \(computerCollectionItem.name)")
                        .font(.headline)
                    Text(computerCollectionItem.processorInfo)
                    Text(computerCollectionItem.totalRam)
                }
            }.padding()
        }.padding(.trailing)
    }
}

#if DEBUG
struct ComputersItemRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ComputersItemRow(computerCollectionItem: ComputerCollectionItem.testData[0])
                .previewLayout(.fixed(width: 400, height: 100))
            
            ComputersItemRow(computerCollectionItem: ComputerCollectionItem.testData[1])
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 400, height: 100))
        }
    }
}
#endif
