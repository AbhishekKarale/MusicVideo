//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by Abhishek Karale on 12/06/2016.
//  Copyright © 2016 AppMonkey. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {

    
    @IBOutlet weak var aboutDisplay: UILabel!
    
    @IBOutlet weak var feedBackDisplay: UILabel!
    
    @IBOutlet weak var securityDisplay: UILabel!
    
    @IBOutlet weak var touchID: UISwitch!
    
    @IBOutlet weak var bestImageDisplay: UILabel!
    
    @IBOutlet weak var APICnt: UILabel!
    
    @IBOutlet weak var sliderCnt: UISlider!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TableView won't scroll now
        tableView.alwaysBounceVertical = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SettingsTVC.preferredFontChange), name: UIContentSizeCategoryDidChangeNotification , object: nil)
        
        
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        title = "Settings"
    }
    
    
    
    @IBAction func touchIdSec(sender: UISwitch) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if touchID.on {
            
            defaults.setBool(true, forKey: "SecSetting")
            
        } else {
            
            defaults.setBool(false, forKey: "SecSetting")
            
        }
        
        
    }
    
    
    
    
    
    
    func preferredFontChange() {
        
        
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedBackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)

        
    }
    
    
    deinit {
        
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    


    
}
