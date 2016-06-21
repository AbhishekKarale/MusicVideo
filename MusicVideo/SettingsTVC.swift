//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by Abhishek Karale on 12/06/2016.
//  Copyright © 2016 AppMonkey. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTVC: UITableViewController, MFMailComposeViewControllerDelegate {

    
    @IBOutlet weak var aboutDisplay: UILabel!
    
    @IBOutlet weak var feedBackDisplay: UILabel!
    
    @IBOutlet weak var securityDisplay: UILabel!
    
    @IBOutlet weak var touchID: UISwitch!
    
    @IBOutlet weak var bestImageDisplay: UILabel!
    
    @IBOutlet weak var bestImageSwitch: UISwitch!
    
    @IBOutlet weak var APICnt: UILabel!
    
    @IBOutlet weak var sliderCnt: UISlider!
    
    
    @IBOutlet weak var numberOfVideosDisplay: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TableView won't scroll now
        tableView.alwaysBounceVertical = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SettingsTVC.preferredFontChange), name: UIContentSizeCategoryDidChangeNotification , object: nil)
        
        
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        bestImageSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey("bestImage")
        
        if NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil {
            
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            APICnt.text = ("\(theValue)")
            sliderCnt.value = Float(theValue)
            
        } else {
            sliderCnt.value = 10.0
            APICnt.text = ("\(Int(sliderCnt.value))")
            
            
        }
        
        
        
        
        title = "Settings"
    }
    
    
    @IBAction func valueChanged(sender: AnyObject) {
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCnt.value), forKey: "APICNT")
        APICnt.text = ("\(Int(sliderCnt.value))")
        
        
    }
    
    
    
    @IBAction func touchIdSec(sender: UISwitch) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if touchID.on {
            
            defaults.setBool(true, forKey: "SecSetting")
            
        } else {
            
            defaults.setBool(false, forKey: "SecSetting")
            
        }
        
        
    }
    
    
    
    @IBAction func bestImageSwitched(sender: UISwitch) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if bestImageSwitch.on {
            defaults.setBool(true, forKey: "bestImage")
        }
        else {
            defaults.setBool(false, forKey: "bestImage")
        }
        
        
    }
    
    
    
    
    
    
    func preferredFontChange() {
        
        
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedBackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        numberOfVideosDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)

        
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 1 {
            
            let mailComposeViewController = configureMail()
            
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            }
            else {
                //No mail account set up on phone
                mailAlert()
                
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
    }
    
    
    
    // Creates the MFMailComposeViewController with specific message
    func configureMail() -> MFMailComposeViewController {
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["feedback@hotmail.com"])
        mailComposeVC.setSubject("Music Video App Feedback")
        mailComposeVC.setMessageBody("Hi Michael, \n \n I would like to share the following feedback... \n", isHTML: false)
        return mailComposeVC
        
    }
    
    
    func mailAlert() {
        let alert = UIAlertController(title: "Alert", message: "No e-Mail account setup for Phone", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // Do something if want
        }
        
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue {
            
        case MFMailComposeResultCancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail saved")
        case MFMailComposeResultSent.rawValue :
            print("Mail SENT")
        case MFMailComposeResultFailed.rawValue:
            print("Mail failed")
        default :
            print ("Unknown issue")
            
        }
        
        // Remember to dismiss mail view controller once message is sent etc.
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    
    
    
    deinit {
        
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    


    
}
