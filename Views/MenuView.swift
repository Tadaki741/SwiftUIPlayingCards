//
//  MenuView.swift
//  SwiftUIPlayingCards
//
//  Created by Duong Vo Dai on 21/08/2022.
//

import SwiftUI

//Menu view will have the navigation view that leads to others
struct MenuView: View {
    
    //Dark mode light mode
    
    
    //Core data passed from the SwiftUIPlayingCardsApp
    @ObservedObject public var coreDM: CoreDataManager;
    
    var body: some View {
        
        //background image
        Spacer();
        //Display the welcome text
        Text("Vietnamese Black Jack")
                            .font(Font.system(size: 46, weight: .bold))
                            .multilineTextAlignment(.center)
                            .overlay {
                                LinearGradient(
                                    colors: [.red, .blue, .green, .yellow],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .mask(
                                    Text("Vietnamese Black Jack")
                                        .font(Font.system(size: 46, weight: .bold))
                                        .multilineTextAlignment(.center)
                                )
                            }
        NavigationView{
            
            
            VStack{
                
                //MARK: PLAY THE GAME
                NavigationLink(destination: askPlayerNameView(coreDM: coreDM),label:{
                    Text("Play Game").bold()
                        .frame(width: 280, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10);
                })
                
                //MARK: LEADERBOARD
                NavigationLink(destination: LeaderboardView(coreDM: coreDM),label:{
                    Text("LEADERBOARD").bold()
                        .frame(width: 280, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10);
                })
                
                //MARK: SETTINGS
                NavigationLink(destination: SettingsView(),label:{
                    Text("Settings").bold()
                        .frame(width: 280, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10);
                })
                
                //MARK: HOW TO PLAY
                NavigationLink(destination: HowToPlayView(),label:{
                    Text("How to play ?").bold()
                        .frame(width: 280, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10);
                })
                
            }
            
            
        }
    }
}

