//
//  SettingsView.swift
//  SwiftUIPlayingCards
//
//  Created by Duong Vo Dai on 24/08/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false;
    @AppStorage("enableMusic") private var enableMusic = false;
    @ObservedObject public var soundManager: SoundManager;
    @State var soundON: Bool = false;
    
    var body: some View {
        
        
        
        
        
        VStack{
            Spacer();
            Text("Game settings").fontWeight(.bold);
            Spacer();
            Picker("Mode",selection: $isDarkMode){
                            Text("Light mode ☀️").tag(false);
                             Text("Dark mode 🌙").tag(true)
            }.pickerStyle(SegmentedPickerStyle()).padding();
            
            Spacer();
            //Button to turn on/off music
            Button(soundON ? "MUSIC ON" : "MUSIC OFF"){
                //If tap on the sound ON
                if(soundON){
                    soundManager.playBackgroundMusic();
                    soundON = false;
                }
                //If tap on the sound OFF
                else if(!soundON){
                    soundManager.stopBackgroundMusic();
                    soundON = true;
                }
            }.padding()
            .frame(width: 280, height: 50)
                .background(soundON ? Color.green : Color.red)
                .foregroundColor(.white)
                .cornerRadius(10);
            Spacer();
            
        }
        
        
        
    }
}


