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
    
    @IBOutlet weak var displayLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        
        //Call api-
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    }
    
    
    func didLoadData(videos: [Videos]) {
        
        print(reachabilityStatus)
        
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
    
    
    func reachabilityStatusChanged() {
     
        switch reachabilityStatus {
            
        case NOACCESS :
            view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        case WIFI :
            view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Reachable with WIFI"
        case WWAN :
            view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Reachable with Cellular"
        default:return
            
        }
        
        
        
        
    }
    
    
    // Is called just as the object is about to be deallocated.
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    


}

