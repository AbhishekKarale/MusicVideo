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
    // SETTERS:
    private var _vName:String
    private var _vImageUrl:String
    private var _vVideoUrl:String
    private var _vPrice : String
    private var _vRights:String
    private var _vArtist : String
    private var _vImid : String
    private var _vGenre: String
    private var _vLinkToiTunes:String
    private var _vReleaseDte: String
    
    
    //This variable gets created from the UI
    
    var vImageData:NSData?  // optional means - it will not have a value until used - don't have to initialise it.
    
    
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
    
    var vPrice : String {
        
        return _vPrice
        
    }
    
    var vRights : String {
        
        return _vRights
        
    }
    
    var vArtist : String {
        
        return _vArtist
    }
    
    var vImid : String {
        
        return _vImid
    }
    
    var vGenre : String {
        
        return _vGenre
    }
    
    var vLinkToiTunes : String {
        
        return _vLinkToiTunes
    }
    
    var vReleaseDte : String {
        
        return _vReleaseDte
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
        
        //vPrice
        
        if let videoPrice = data["im:price"] as? JSONDictionary,
        vidPrice = videoPrice["label"] as? String {
            
            self._vPrice = vidPrice
            
        } else {
            self._vPrice = ""
        }
        
        //vRights
        
        if let videoRights = data["rights"] as? JSONDictionary,
        vidRights = videoRights["label"] as? String {
            
            self._vRights = vidRights
                
        } else {
            
            self._vRights = ""
        }
        
        //vArtist
        
        if let videoArtist = data["im:artist"] as? JSONDictionary,
        vidArtist = videoArtist ["label"] as? String {
                
            self._vArtist = vidArtist
            
        } else {
            
            self._vArtist = ""
        }
        
        //vImid
        
        if let vImageId = data["id"] as? JSONDictionary,
        vImmid = vImageId["attributes"] as? JSONDictionary,
        vidId = vImmid["im:id"] as? String {
                
            self._vImid = vidId
            
        } else {
            
            self._vImid = ""
        }
        
        //vGenre
        
        if let vidGenre = data["category"] as? JSONDictionary,
        videoGenre = vidGenre["attributes"] as? JSONDictionary,
        viddGenre = videoGenre["term"] as? String {
            
            self._vGenre = viddGenre
                
        } else {
            
            self._vGenre = ""
        }
        
        //vLinkToItunes
        
        if let vLink = data["id"] as? JSONDictionary,
        vidLink = vLink["label"] as? String {
            
            self._vLinkToiTunes = vidLink
                
        } else {
            
            self._vLinkToiTunes = ""
        }
        
        //vReleaseDte
        
        if let vidReleaseDate = data["im:releaseDate"] as? JSONDictionary,
        vReleaseD = vidReleaseDate["attributes"] as? JSONDictionary,
        vidReleaseDte = vReleaseD["label"] as? String {
            
            self._vReleaseDte = vidReleaseDte
                
        } else {
            
            self._vReleaseDte = ""
        }
        
        
        
    }
    
    
    
    
    
}
