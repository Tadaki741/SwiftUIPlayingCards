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
 
 I use this github repository for the animation, adding and removing function of the card decks [1]
 [1] Github, ChrisMash SwiftUI Playing Card. Accessed on: Aug.15, 2022. [Online]. Available: https://github.com/ChrisMash/SwiftUI-Playing-Cards
 
 
*/

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
