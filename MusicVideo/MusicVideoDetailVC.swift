//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Abhishek Karale on 11/06/2016.
//  Copyright © 2016 AppMonkey. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

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
    
    
    @IBAction func socialMedia(sender: UIBarButtonItem) {
        shareMedia()
        
        
    }
    
    func shareMedia() {
        
        let activity1 = "Have you had the opportunity to see this Music Video?"
        let activity2 = ("\(videos.vName) by \(videos.vArtist)")
        let activity3 = "Watch it and tell me what you thnk?"
        let activity4 = videos.vLinkToiTunes
        let activity5 = "(Shared with Music Video App- Step It UP!)"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3, activity4, activity5], applicationActivities: nil)
        
        // Can exclude certain bits
        // activityViewController.excludedActivityTypes = [UIActivityTypeMail, UIActivityTypePostToTwitter etc]
        
        // You can do stuff after they share it!
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            
            if activity == UIActivityTypeMail {
                print ("email selected")
            }
            
        }
        
        self.presentViewController(activityViewController, animated:  true, completion: nil)
        
        
        
        
    }
    
    
    
    
    @IBAction func playVideo(sender: UIBarButtonItem) {
        
        let url = NSURL(string: videos.vVideoUrl)!
        
        let player = AVPlayer(URL: url)
        
        let playerViewController = AVPlayerViewController()
        
        playerViewController.player = player
        
        self.presentViewController(playerViewController, animated: true) { 
            playerViewController.player?.play()
        }
        
    }
    

   
}
