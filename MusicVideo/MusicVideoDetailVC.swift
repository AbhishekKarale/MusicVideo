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
import LocalAuthentication

class MusicVideoDetailVC: UIViewController {

    
    var videos: Videos!
    
    var securitySwitch : Bool = false
    
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
        
        securitySwitch = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        if videos.vImageData != nil {
            
            videoImage.image = UIImage(data: videos.vImageData!)
            
        } else {
            
            videoImage.image = UIImage(named: "imageNotAvailable")
        }
        
        
    }
    
    
    @IBAction func socialMedia(sender: UIBarButtonItem) {
        
        switch securitySwitch {
        case true :
            touchIdChk()
        default :
            shareMedia()
        }
        
    }
    
    
    func touchIdChk() {
        
        // Create alert 
        let alert = UIAlertController(title: "", message: "", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "continue", style: .Cancel, handler: nil))
        
        //Create local authentication context 
        let context = LAContext()
        var touchIDError : NSError?
        let reasonString = "Touch Id authentication is needed to share info on Social media"
        
        //Check if we can access local device authentication
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &touchIDError) {
            //Check what the authentication response was
            
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) in
                
                if success {
                    //User authenticated using Local device authentication successfully!
                    // Evaluate policy method runs on background private thread- need to bring back to main
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                        self.shareMedia()
                    }
                }
                else {
                    alert.title = "Unsucessful"
                    
                    switch LAError(rawValue: policyError!.code)! {
                        
                    case .AppCancel :
                        alert.message = "Authentication was cancelled by application"
                        
                    case .AuthenticationFailed :
                        alert.message = "The user failed to provide valid credentials"
                        
                    case .PasscodeNotSet :
                        alert.message = "Password is not set on the device"
                        
                    case .SystemCancel :
                        alert.message = "Authentication was cancelled by the system"
                        
                    case .TouchIDLockout :
                        alert.message = "You cancelled the request"
                        
                    case .UserFallback :
                        alert.message = "Password not accepted, must use touch ID"
                        
                    default :
                        alert.message = "Unable to authenticate"
                        
                    }
                    
                    //Show alert
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
                
                
            })
            
        }
        else {
           // Unable to access local device authentication
            
            alert.title = "Error"
            
            //Set the error alert message with more information
            switch LAError(rawValue: (touchIDError?.code)!)! {
                
            case .TouchIDNotEnrolled :
                alert.message = "Touch ID is not enrolled"
                
            case .TouchIDNotAvailable :
                alert.message = "TouchID is not available on the device"
                
            case .PasscodeNotSet :
                alert.message = "Password has not been set"
                
            case .InvalidContext :
                alert.message = "The context is invalid"
                
            default :
                alert.message = "Local authentication not available"
                
            }
            
            //Show alert
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
            
        }
        
        
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
