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
    //MARK: State object to play background music
    @StateObject private var soundManagerObject = SoundManager();
    
    
    var body: some Scene {
        WindowGroup {
            MenuView(coreDM: coreDM, soundManager: soundManagerObject)
                .preferredColorScheme(isDarkMode ? .dark : .light).accentColor(.primary)
                .environment(\.managedObjectContext,coreDM.persistentContainer.viewContext);
        }
    }
}
