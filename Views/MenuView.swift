//
//  MenuView.swift
//  SwiftUIPlayingCards
//
//  Created by Duong Vo Dai on 21/08/2022.
//

import SwiftUI

//Menu view will have the navigation view that leads to others
struct MenuView: View {
    
    @State var playerSelectPlayGame: Bool = false;
    @State var playerSelectHowToPlay: Bool = false;
    @State var playerSelectLeaderboard: Bool = false;
    
    
    var body: some View {
        
        if playerSelectPlayGame {
            askPlayerNameView();
        }
        
        else if playerSelectHowToPlay{
            HowToPlayView();
        }
        
        else if playerSelectLeaderboard {
            LeaderboardView();
        }
        
        
        VStack{
            
            Button("PLAY GAME"){
                
                playerSelectPlayGame.toggle();
                
            }
            
            Button("LEADERBOARD"){
                
                playerSelectLeaderboard.toggle();
                
            }
            
            Button("HOW TO PLAY ?"){
                playerSelectHowToPlay.toggle();
            }
            
            
        }
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
