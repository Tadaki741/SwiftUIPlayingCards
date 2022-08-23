//
//  CoreDataManager.swift
//  SwiftUIPlayingCards
//
//  Created by Duong Vo Dai on 23/08/2022.
//

import Foundation
import CoreData

class CoreDataManager{
    
    let persistentContainer: NSPersistentContainer
    
    //Constructor
    init(){
        persistentContainer = NSPersistentContainer(name: "CardGameDataModel")
        persistentContainer.loadPersistentStores{(description,error) in
            if let error = error{
                fatalError("Core Data Store failed\(error.localizedDescription)")
            }
        }
    }
    
    
    //MARK: Function to save player score
    func savePlayerPoint(playerName: String, playerScore: String){
        
    }
    
    
}
