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

import Foundation
import CoreData

//MARK: CoreDataManager
class CoreDataManager: ObservableObject{
    
    let persistentContainer: NSPersistentContainer
    
    //MARK: Constructor
    init(){
        persistentContainer = NSPersistentContainer(name: "CardGameCoreData")
        persistentContainer.loadPersistentStores{(description,error) in
            if let error = error{
                fatalError("Core Data Store failed\(error.localizedDescription)")
            }
        }
    }
    
    
    //MARK: Function to save player score
    func savePlayer(name: String, score: String, computerScore: String){
        let player = Player(context: persistentContainer.viewContext);
        let scoreString = String(score);
        let computerString = String(computerScore);
        //Convert the string to number
        player.name = name;
        player.computerScore = computerString;
        player.score = scoreString;
        
        
        
        do{
            try persistentContainer.viewContext.save();
        }
        catch{
            print("Failed to save player !");
        }
    }
    
    //MARK: Return all the players to display on the leaderboard
    func getAllPlayers() -> [Player]{
        //Fetch data
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest);
        }
        catch{
            return [];
        }
        
    }
    
    //MARK: delete a particular player
    func deletePlayer(player: Player){
        persistentContainer.viewContext.delete(player);
        do{
            
            try persistentContainer.viewContext.save();
            
        }
        
        catch{
            persistentContainer.viewContext.rollback();
            print("Something wrong when deleting !");
        }
    }
    
    
}
