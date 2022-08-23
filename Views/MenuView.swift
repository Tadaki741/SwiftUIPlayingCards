//
//  MenuView.swift
//  SwiftUIPlayingCards
//
//  Created by Duong Vo Dai on 21/08/2022.
//

import SwiftUI

//Menu view will have the navigation view that leads to others
struct MenuView: View {
    
    var body: some View {
        
        NavigationView{
            
            
            VStack{
                
                //MARK: PLAY THE GAME
                NavigationLink(destination: askPlayerNameView(),label:{
                    Text("Play Game").bold()
                        .frame(width: 280, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10);
                })
                
                //MARK: LEADERBOARD
                NavigationLink(destination: LeaderboardView(),label:{
                    Text("LEADERBOARD").bold()
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

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
