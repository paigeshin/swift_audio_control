//
//  ViewController.swift
//  Swift_simple_music_player
//
//  Created by shin seunghyun on 2020/04/12.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gettingSongName()
    }
    
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
                    print(mySong)
                    
                }
            }
        } catch {
            
        }
        
    }


}

