//
//  GamingAddView.swift
//  RetroCollection
//
//  Created by JR Endean on 5/30/22.
//

import SwiftUI

struct GamingAddView: View {
    
    @Binding var gamingCollectionItem: GamingCollectionItem
    
    var body: some View {
        Text("Gaming Add")
    }
}

#if DEBUG
struct GamingAddView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var newItem: GamingCollectionItem = GamingCollectionItem()
        
        var body: some View {
            GamingAddView(gamingCollectionItem: $newItem)
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
