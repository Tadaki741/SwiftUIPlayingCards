/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Your name (e.g. Nguyen Van Minh)
  ID: S3821186
  Created  date: 15/08/2022
  Last modified: 28/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false;
    @AppStorage("enableMusic") private var enableMusic = false;
    @ObservedObject public var soundManager: SoundManager;
    @State var soundON: Bool = false;
    
    var body: some View {
        
        VStack{
            Spacer();
            //MARK: Settings text
            Text("Game settings").fontWeight(.bold);
            Spacer();
            
            
            //MARK: Toggle button
            Picker("Mode",selection: $isDarkMode){
                            Text("Light mode ☀️").tag(false);
                             Text("Dark mode 🌙").tag(true)
            }.pickerStyle(SegmentedPickerStyle()).padding();
            
            Spacer();
            
            //MARK: Button to turn on/off music
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


