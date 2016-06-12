//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Abhishek Karale on 11/06/2016.
//  Copyright © 2016 AppMonkey. All rights reserved.
//

import UIKit

class MusicVideoDetailVC: UIViewController {

    
    var videos: Videos!
    
    
    @IBOutlet weak var vName: UILabel!
    
    @IBOutlet weak var videoImage: UIImageView!
    
    @IBOutlet weak var vGenre: UILabel!
    
    @IBOutlet weak var vPrice: UILabel!
    
    @IBOutlet weak var vRights: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = videos.vArtist
        
        vName.text = videos.vName
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights
        vGenre.text = videos.vGenre
        
        if videos.vImageData != nil {
            
            videoImage.image = UIImage(data: videos.vImageData!)
            
        } else {
            
            videoImage.image = UIImage(named: "imageNotAvailable")
        }
        
        
        
    }

   
}
