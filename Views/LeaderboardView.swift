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
            List{
                
                
                ForEach(playerList, id: \.self){ player in
                    HStack{
                        Text(player.name ?? "");
                        Text(player.score ?? "");
                    }
                }.onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        let player = playerList[index];
                        //Delete using core data manager
                        coreDM.deletePlayer(player: player);
                        
                        //Refresh UI again
                        populatePlayerData();
                    }
                })
                
                
                
            }
            
        }.onAppear(perform: {
            
            populatePlayerData();
            
        })
        
    }
    
    private func populatePlayerData(){
        playerList = coreDM.getAllPlayers();
    }
    
    
    
    
}

