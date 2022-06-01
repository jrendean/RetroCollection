//
//  GamingEditView.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import SwiftUI

struct GamingEditView: View {
    
    @Binding var gamingCollectionItem: GamingCollectionItem
     
    var body: some View {
        Text("Gaming Edit")
    }
}

#if DEBUG
struct GamingEditView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var item = GamingCollectionItem.testData[0]
        
        var body: some View {
            GamingEditView(gamingCollectionItem: $item)
        }
    }
    
    static var previews: some View {
        NavigationView {
            StatefulPreviewWrapper()
        }
    }
}
#endif
