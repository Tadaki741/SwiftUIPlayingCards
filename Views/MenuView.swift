//
//  MenuView.swift
//  SwiftUIPlayingCards
//
//  Created by Duong Vo Dai on 21/08/2022.
//

import SwiftUI

//Menu view will have the navigation view that leads to others
struct MenuView: View {
    
    
    //Core data passed from the SwiftUIPlayingCardsApp
    @ObservedObject public var coreDM: CoreDataManager;
    @ObservedObject public var soundManager: SoundManager;
    
    var body: some View {
        
        

            NavigationView{
                
                
                VStack{
                    
                    Text("Vietnamese BlackJack")
                        .font(Font.system(size: 46, weight: .bold))
                        .multilineTextAlignment(.center)
                        .overlay {
                            LinearGradient(
                                colors: [.red, .blue, .green, .yellow],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .mask(
                                Text("Vietnamese BlackJack")
                                    .font(Font.system(size: 46, weight: .bold))
                                    .multilineTextAlignment(.center)
                            )
                        }
                    
                    
                    //MARK: PLAY THE GAME
                    NavigationLink(destination: askPlayerNameView(coreDM: coreDM, soundManager: soundManager),label:{
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
                    NavigationLink(destination: SettingsView(soundManager: soundManager),label:{
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
            }.onAppear{
                //MARK: Play music when user go to menu
                soundManager.playBackgroundMusic();
            }
            
    }
}

