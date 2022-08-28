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

struct LeaderboardView: View {
    
    let coreDM: CoreDataManager;
    @State private var playerList: [Player] = [Player]();
    
    var body: some View {
        Text("LEADER BOARD VIEW HERE")
        
        //TODO: LOAD THE LIST OF USERS AND THEIR HIGHSCORE
        VStack{
            HStack{
                Text("Username win count -- Computer win count");
            }
            
            //Display the data as list
            List{
                
                
                ForEach(playerList, id: \.self){ player in
                    HStack{
                        Text(player.name ?? "");
                        Text(player.score ?? "");
                        Text("--");
                        Text(player.computerScore ?? "");
                        Text("Computer");
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

