//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Abhishek Karale on 09/06/2016.
//  Copyright © 2016 AppMonkey. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicVideoTVC.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicVideoTVC.preferredFontChange), name: UIContentSizeCategoryDidChangeNotification , object: nil)
        

        
        reachabilityStatusChanged()
        
        
    }
    
    
    func preferredFontChange () {
        
        
        print ("The preferred font has changed")
        
        
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
        
        tableView.reloadData()
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func reachabilityStatusChanged() {
        
        switch reachabilityStatus {
            
        case NOACCESS :
           // view.backgroundColor = UIColor.redColor()
            
            //move back to Main Queue
            
            dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "No internet Access", message: "Please make sure you are connected to the internet", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: { (action) in
                
                print ("Cancel")
                
            })
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { (action) in
                
                print("delete")
                
            })
            
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                
                print("ok")
                
            })
            
           
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            }
            
        default:
            //view.backgroundColor = UIColor.greenColor()
            
            if videos.count > 0 {
                
                print("do not refresh API")
                
            } else {
                
                runAPI()
                
            }
            
            
        }
        
        
        
        
    }
    
    
    func runAPI() {
        
        //Call api-
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=200/json", completion: didLoadData)
        

    }
    
    
    // Is called just as the object is about to be deallocated.
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }
    
    
    private struct storyboard {
        static let cellReuseIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
    }
    
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell

        cell.video = videos[indexPath.row]
        
       
        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == storyboard.segueIdentifier {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let video = videos[indexPath.row]
                let destinationVC = segue.destinationViewController as! MusicVideoDetailVC
                destinationVC.videos = video
                
            }
            
        }
        
        
    }
    
    
    

}
