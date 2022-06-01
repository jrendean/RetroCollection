//
//  GamingItemRow.swift
//  RetroCollection
//
//  Created by JR Endean on 5/31/22.
//

import SwiftUI

struct GamingItemRow: View {
    var gamingCollectionItem: GamingCollectionItem
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                if gamingCollectionItem.photos.isEmpty {
                    Image(systemName: gamingCollectionItem.type == "Laptop" ? "laptopcomputer" : "gamecontroller")
                        .symbolRenderingMode(.hierarchical)
                        .font(.largeTitle)
                        .imageScale(.large)
                } else {
                    let defaultPhoto = gamingCollectionItem.photos.first(where: { $0.defaultImage })
                    //let image = DataManager.loadImage(filename: defaultPhoto == nil ? retroCollectionItem.photos[0].id.uuidString : defaultPhoto!.id.uuidString)
                    let imageData = defaultPhoto == nil ? gamingCollectionItem.photos[0].image.imageData : defaultPhoto?.image.imageData
                    Image.init(uiImage: UIImage(data: imageData!)!)
                        .resizable()
                        .frame(width: 75, height: 75, alignment: .center)
                }
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("\(gamingCollectionItem.manufacturer) \(gamingCollectionItem.name)")
                        .font(.headline)
                    //Text(gamingCollectionItem.processorInfo)
                    //Text(gamingCollectionItem.totalRam)
                }
            }.padding()
        }.padding(.trailing)
    }
}

#if DEBUG
struct GamingItemRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GamingItemRow(gamingCollectionItem: GamingCollectionItem.testData[0])
                .previewLayout(.fixed(width: 400, height: 100))
            
            GamingItemRow(gamingCollectionItem: GamingCollectionItem.testData[1])
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 400, height: 100))
        }
    }
}
#endif
