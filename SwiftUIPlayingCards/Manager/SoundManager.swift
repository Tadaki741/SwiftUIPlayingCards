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


import AVFoundation
import AVKit
var audioPlayer: AVAudioPlayer?

class SoundManager: ObservableObject{
    
    var player :AVAudioPlayer?
    
    func playBackgroundMusic(){
        
        
        guard let url = Bundle.main.url(forResource: "CODEXBackgroundMusic", withExtension: ".mp3") else {return}
        
        do {
            
            player = try AVAudioPlayer(contentsOf: url);
            player?.play();
            //We are playing background music, so it should loop infinitely
            player?.numberOfLoops = -1;
            
        }
        
        catch let error {
            print("error playing background sound !->\(error.localizedDescription)")
        }
    }
    
    func stopBackgroundMusic(){
        player?.stop();
    }
}

func playSound(sound: String, type: String) {
  if let path = Bundle.main.path(forResource: sound, ofType: type) {
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path));
        audioPlayer?.play()
    } catch {
      print("ERROR: Could not find and play the sound file!")
    }
  }
}
