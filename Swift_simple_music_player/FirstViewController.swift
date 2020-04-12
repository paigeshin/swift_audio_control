//
//  ViewController.swift
//  Swift_simple_music_player
//
//  Created by shin seunghyun on 2020/04/12.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import AVFoundation

//Trick. 이렇게 해놓으면 다른 곳에서도 이 값을 가져올 수 있음, 보통은 protocol을 파나 급하면 이 방법도 괜찮아 보임
var audioPlayer = AVAudioPlayer()
var songs = [String]()
var thisSong = 0


class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gettingSongName()
    }
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = songs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            
            let audioPath = Bundle.main.path(forResource: songs[indexPath.row], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            //어떤 음악이 재생되고 있는지 알려줌
            thisSong = indexPath.row
            

            
        } catch {
            
            print(error.localizedDescription)
            
        }
    }
    
    
}

