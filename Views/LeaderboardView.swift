//
//  LeaderboardView.swift
//  SwiftUIPlayingCards
//
//  Created by Duong Vo Dai on 21/08/2022.
//

import SwiftUI

struct LeaderboardView: View {
    
    let coreDM: CoreDataManager;
    @State private var playerList: [Player] = [Player]();
    
    var body: some View {
        Text("LEADER BOARD VIEW HERE")
        
        //TODO: LOAD THE LIST OF USERS AND THEIR HIGHSCORE
        VStack{
            HStack{
                Text("Username");
                Text("Score");
            }
            
            //Display the data as list
            List(playerList, id: \.self ){ player in
                HStack{
                    Text(player.name ?? "")
                    Text(player.score ?? "")
                }
            }
            
        }.onAppear(perform: {
            playerList = coreDM.getAllPlayers();
            
        })
        
    }
}

