//
//  SettingsView.swift
//  SwiftUIPlayingCards
//
//  Created by Duong Vo Dai on 24/08/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false;
    
    
    var body: some View {
        
        
        VStack{
            Picker("Mode",selection: $isDarkMode){
                             Text("Light mode ☀️").tag(false);
                             Text("Dark mode 🌙").tag(true)
                         }.pickerStyle(SegmentedPickerStyle()).padding()
        }
        
        
    }
}


