//
//  SwiftUIPlayingCardsApp.swift
//  SwiftUIPlayingCards
//
//  Created by Chris Mash on 15/02/2022.
//

import SwiftUI

@main
struct SwiftUIPlayingCardsApp: App {
    
    @StateObject private var coreDM = CoreDataManager();
    
    
    var body: some Scene {
        WindowGroup {
            MenuView(coreDM: coreDM).environment(\.managedObjectContext,coreDM.persistentContainer.viewContext);
        }
    }
}
