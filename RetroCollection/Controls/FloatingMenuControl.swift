//
//  FloatingMenu.swift
//  RetroCollection
//
//  Created by JR Endean on 12/29/21.
//

import SwiftUI

//https://blckbirds.com/post/floating-action-button-in-swiftui/

struct FloatingMenuControl: View {
    
    @State var showMenuItem1 = false
    @State var showMenuItem2 = false
    @State var showMenuItem3 = false
    
    var body: some View {
        VStack {
            Spacer()
            if showMenuItem1 {
                MenuItem(icon: "internaldrive")
            }
            if showMenuItem2 {
                MenuItem(icon: "cable.connector")
            }
            if showMenuItem3 {
                MenuItem(icon: "square.and.arrow.up.fill")
            }
            Button(action: {
                self.showMenu()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.accentColor)
                    .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
            }
        }
    }
    
    func showMenu() {
        withAnimation {
            self.showMenuItem3.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.showMenuItem2.toggle()
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            withAnimation {
                self.showMenuItem1.toggle()
            }
        })
    }
}

struct MenuItem: View {
    var icon: String
    
    var body: some View {
        Button(action: {
            // TODO:
        }) {
            ZStack {
                Circle()
                    .foregroundColor(.accentColor)
                    .frame(width: 50, height: 50)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
            .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
            .transition(.move(edge: .trailing))
        }
    }
}
