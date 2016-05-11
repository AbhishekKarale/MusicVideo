//
//  ViewController.swift
//  MusicVideo
//
//  Created by Abhishek Karale on 10/05/2016.
//  Copyright © 2016 AppMonkey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call api-
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    }
    
    
    func didLoadData(videos: [Videos]) {
        
        self.videos = videos
        
        for item in videos {
            
            print("name = \(item.vName)")
        }
        
        for (index, item) in videos.enumerate() {
            
            print("\(index) name is \(item.vName)")
            
        }

        

        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

