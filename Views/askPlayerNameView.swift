//
//  askPlayerNameView.swift
//  SwiftUIPlayingCards
//
//  Created by Duong Vo Dai on 23/08/2022.
//

import SwiftUI

struct askPlayerNameView: View {
    
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var showError = false
        
    var body: some View {
        HStack {
            Text("User name")
            TextField("type here", text: $userName)
        }.padding()
    }
}


