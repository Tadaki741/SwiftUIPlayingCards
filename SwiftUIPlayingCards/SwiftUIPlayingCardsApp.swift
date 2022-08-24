//
//  SwiftUIPlayingCardsApp.swift
//  SwiftUIPlayingCards
//
//  Created by Chris Mash on 15/02/2022.
//

import SwiftUI

@main
struct SwiftUIPlayingCardsApp: App {
    
    @AppStorage("isDarkMode") private var isDarkMode = false;
    
    //MARK: State object to store data
    @StateObject private var coreDM = CoreDataManager();
    
    
    var body: some Scene {
        WindowGroup {
            MenuView(coreDM: coreDM)
                .preferredColorScheme(isDarkMode ? .dark : .light).accentColor(.primary)
                .environment(\.managedObjectContext,coreDM.persistentContainer.viewContext);
        }
    }
}
