//
//  askPlayerNameView.swift
//  SwiftUIPlayingCards
//
//  Created by Duong Vo Dai on 23/08/2022.
//

import SwiftUI

struct askPlayerNameView: View {
    
    @ObservedObject public var coreDM: CoreDataManager;
    @ObservedObject public var soundManager: SoundManager;
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var showError = false
        
    var body: some View {
    
        VStack{
            
            HStack{
                Text("Username: ");
                TextField("Enter your username",text: $userName);
            }
            
            
            NavigationLink(destination: ContentView(coreDM: coreDM, soundManager: soundManager, userNameFromAskPlayerNameView: $userName),label: {
                if(!userName.isEmpty){
                    Text("Let's Play").bold()
                        .frame(width: 280, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10);
                }
                
            })
            
            
            
        }
        
    }
}


