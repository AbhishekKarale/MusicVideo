//
//  APIManager.swift
//  MusicVideo
//
//  Created by Abhishek Karale on 10/05/2016.
//  Copyright © 2016 AppMonkey. All rights reserved.
//

import Foundation

class APIManager {
    
    
    // Creating load data function which will download from itunes api.
    
    func loadData(urlString:String, completion: (result:String) -> Void) {
        
        //To stop caching.
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        //let session = NSURLSession.sharedSession()
        // Create an object 'session' instantiated from the class NSLURLSession.shared session. This is a singleton design pattern. Can't only instantiate the object ONCE.
        
        let url = NSURL(string: urlString)!
        //Take urlString and convert it into an NSURL
        
        //Now iniatiate a task. Starts an assynchronous background call- runs it on background thread.
        //But task starts out in a suspended state
        //Need to do 'task.resume' to execute this task
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            
            //this is where we move background ---> move it to main thread. 
           
                if error != nil {
                     dispatch_async(dispatch_get_main_queue()) {
                        completion(result: (error!.localizedDescription))
                    }
                } else {
                    completion(result: "NSURLSession succesful")
                    //print(data)
                    
                    //Got data- now need to convert it into JSON...
                    
                    do {
                        
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String:AnyObject] {
                            
                            print(json)
                            
                            //send that we converted it back to main thread using a priority high!
                            
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                dispatch_async(dispatch_get_main_queue()){
                                    completion(result: "JSONSerialisation Succesful")
                                }
                            }
                            
                        }
                        
                    } catch {
                        dispatch_async(dispatch_get_main_queue()){
                            completion(result: "error in NSJSONSerialisation")
                        }
                        
                    }
                }
            
            
        }
        
        
        task.resume()
        
        
        
    }
    
    
    
}
