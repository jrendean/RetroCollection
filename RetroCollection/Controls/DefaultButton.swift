//
//  DefaultButton.swift
//  RetroCollection
//
//  Created by JR Endean on 3/29/22.
//

import SwiftUI

struct DefaultButton: View {
    
    @Binding var photo: Photo
    @Binding var retroCollectionItem: ComputerCollectionItem
    
    var body: some View {
        Button(action: {
            for i in retroCollectionItem.photos.indices {
                retroCollectionItem.photos[i].defaultImage = false
            }
            photo.defaultImage = true
            
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
    }
}

#if DEBUG
struct DefaultButton_Previews: PreviewProvider {
    static var previews: some View {
        //DefaultButton()
        EmptyView()
    }
}
#endif
