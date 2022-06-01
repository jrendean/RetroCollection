//
//  ComponentItemRow.swift
//  RetroCollection
//
//  Created by JR Endean on 5/31/22.
//

import SwiftUI

struct ComponentItemRow: View {
    var componentCollectionItem: ComponentCollectionItem
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                if componentCollectionItem.photos.isEmpty {
                    Image(systemName: componentCollectionItem.type == "Laptop" ? "laptopcomputer" : "memorychip")
                        .symbolRenderingMode(.hierarchical)
                        .font(.largeTitle)
                        .imageScale(.large)
                } else {
                    let defaultPhoto = componentCollectionItem.photos.first(where: { $0.defaultImage })
                    //let image = DataManager.loadImage(filename: defaultPhoto == nil ? retroCollectionItem.photos[0].id.uuidString : defaultPhoto!.id.uuidString)
                    let imageData = defaultPhoto == nil ? componentCollectionItem.photos[0].image.imageData : defaultPhoto?.image.imageData
                    Image.init(uiImage: UIImage(data: imageData!)!)
                        .resizable()
                        .frame(width: 75, height: 75, alignment: .center)
                }
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("\(componentCollectionItem.manufacturer) \(componentCollectionItem.name)")
                        .font(.headline)
                    //Text(componentCollectionItem.processorInfo)
                    //Text(componentCollectionItem.totalRam)
                }
            }.padding()
        }.padding(.trailing)
    }
}

#if DEBUG
struct ComponentItemRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ComponentItemRow(componentCollectionItem: ComponentCollectionItem.testData[0])
                .previewLayout(.fixed(width: 400, height: 100))
            
            ComponentItemRow(componentCollectionItem: ComponentCollectionItem.testData[1])
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 400, height: 100))
        }
    }
}
#endif
