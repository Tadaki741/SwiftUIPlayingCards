//
//  SoundManager.swift
//  SwiftUIPlayingCards
//
//  Created by Duong Vo Dai on 24/08/2022.
//


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
