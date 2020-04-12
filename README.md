# swift_audio_control


# What I learned from this project

### 원래는 controller 간에 protocol을 파서 데이터를 주고 받지만, 정말 급하면 class 밖에 변수를 선언해서 값을 공유하는 것도 나빠보이지 않는다.

    //Trick. 이렇게 해놓으면 다른 곳에서도 이 값을 가져올 수 있음, 보통은 protocol을 파나 급하면 이 방법도 괜찮아 보임
    var audioPlayer = AVAudioPlayer()
    var songs = [String]()
    var thisSong = 0


    class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
        
    
    }


### Directory Path 가져와서 multiple file looping

    //song name을 extract해서 play 해줄 것임.
    func gettingSongName(){
        //Folder URL, file이 여러개여서 그렇다.
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        
        do {
            //폴더안에 있는 파일들의 path를 가져옴. 그것을 토대로 loop를 돌릴 것임.
            //❗️Swift에서는 굳이 폴더이름 같은 것을 지정해주지 않아도 알아서 찾음.
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: .skipsHiddenFiles)
            for song in songPath {
                var mySong = song.absoluteString
                if mySong.contains(".mp3") {
                    //`/`를 기준으로 나눠줌. javascript의 string.split('/') 와 같음
                    let findString = mySong.components(separatedBy: "/")
                    
                    //맨 마지막 값을 가져옴.
                    mySong = findString[findString.count - 1]
                    //% 를 공백으로 대체. javascript의 string.replace('/', ' ') 와 같음
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    songs.append(mySong)
                }
            }
            
            tableView.reloadData()
            
        } catch {
            
        }
        
    }


### Player Control


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


# Chunk

###  Folder URL 가져오기

    let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)

### Folder 안에 content 가져오기

    let songPath = try FileManager.default.contentsOfDirectory(at: folderURL,
                                                                    includingPropertiesForKeys: nil,
                                                                    options: .skipsHiddenFiles)

### String handling


    for song in songPath {
        var mySong = song.absoluteString
        if mySong.contains(".mp3") {
            //`/`를 기준으로 나눠줌. javascript의 string.split('/') 와 같음
            let findString = mySong.components(separatedBy: "/")
            
            //맨 마지막 값을 가져옴.
            mySong = findString[findString.count - 1]
            //% 를 공백으로 대체. javascript의 string.replace('/', ' ') 와 같음
            mySong = mySong.replacingOccurrences(of: "%20", with: " ")
            mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
            songs.append(mySong)
        }
    }
