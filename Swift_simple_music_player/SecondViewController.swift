//
//  SecondViewController.swift
//  Swift_simple_music_player
//
//  Created by shin seunghyun on 2020/04/12.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songTitle.text = songs[thisSong]
        
    }
    
    @IBAction func play(_ sender: UIButton) {
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        }
    }
    
    @IBAction func pause(_ sender: UIButton) {
        
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            songTitle.text = songs[thisSong]
        }
    }
    
    @IBAction func prev(_ sender: UIButton) {
        if thisSong >= 1 {
            playThis(song: songs[thisSong - 1])
            thisSong -= 1
            songTitle.text = songs[thisSong]
        }
        
    }
    
    @IBAction func next(_ sender: UIButton) {
        if thisSong < songs.count - 1 {
            playThis(song: songs[thisSong + 1])
            thisSong += 1
            songTitle.text = songs[thisSong]
        }
    }
    
    @IBAction func slider(_ sender: UISlider) {
        audioPlayer.volume = sender.value
    }
    
    func playThis(song: String){
        do {
            
            let audioPath = Bundle.main.path(forResource: song, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            
        } catch {
            
            print(error.localizedDescription)
            
        }
    }
    
    
    
    
}
