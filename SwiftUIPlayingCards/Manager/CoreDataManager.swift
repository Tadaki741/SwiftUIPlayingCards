//
//  CoreDataManager.swift
//  SwiftUIPlayingCards
//
//  Created by Duong Vo Dai on 23/08/2022.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject{
    
    let persistentContainer: NSPersistentContainer
    
    //Constructor
    init(){
        persistentContainer = NSPersistentContainer(name: "CardGameCoreData")
        persistentContainer.loadPersistentStores{(description,error) in
            if let error = error{
                fatalError("Core Data Store failed\(error.localizedDescription)")
            }
        }
    }
    
    
    //MARK: Function to save player score
    func savePlayer(name: String, score: String){
        let player = Player(context: persistentContainer.viewContext);
        let scoreString = String(score);
        //Convert the string to number
        player.name = name;
        player.score = scoreString;
        
        
        
        do{
            try persistentContainer.viewContext.save();
        }
        catch{
            print("Failed to save player !");
        }
    }
    
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
    
    
}