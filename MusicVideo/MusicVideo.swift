//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Abhishek Karale on 10/05/2016.
//  Copyright © 2016 AppMonkey. All rights reserved.
//

import Foundation

class Videos {
    
    //Data Encapsulation
    
    private var _vName:String
    private var _vImageUrl:String
    private var _vVideoUrl:String
    
    
    //Make getters for above. i.e. Can look at them, but can't update
    
    var vName : String {
        return _vName
    }
    
    var vImageUrl : String {
        return _vImageUrl
    }
    
    var vVideoUrl : String {
        
        return _vVideoUrl
    }
    
    
    // Initialisers
    
    init(data:JSONDictionary) {
        
        //Video Name - this is called ' optional binding using compound if let statements'
        
        if let name = data["im:name"] as? JSONDictionary, vName = name["label"] as? String {
            self._vName = vName
        } else {
            _vName = ""
        }
        
        //ImageUrl
        
        if let img = data["im:image"] as? JSONArray,
        image = img[2] as? JSONDictionary,
        immage = image["label"] as? String {
            
            _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
            
        } else {
            
            _vImageUrl = ""
            
        }
        
        //VideoUrl
        
        if let videoUrl = data["link"] as? JSONArray,
        vUrl = videoUrl[1] as? JSONDictionary,
        vidUrl = vUrl["attributes"] as? JSONDictionary,
        videooUrl = vidUrl["href"] as? String {
            
          self._vVideoUrl = videooUrl
                
        } else {
            
            self._vVideoUrl = ""
        }
        
        
    }
    
    
    
    
    
}
