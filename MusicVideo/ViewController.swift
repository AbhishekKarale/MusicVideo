//
//  ViewController.swift
//  MusicVideo
//
//  Created by Abhishek Karale on 10/05/2016.
//  Copyright © 2016 AppMonkey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call api-
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    }
    
    
    func didLoadData(result:String) {
        
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .Default) { (action) -> Void in
            //do something if click ok
            
        }
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

