//
//  UserListTableViewController.swift
//  ContactCard
//
//  Created by Boris Besemer on 07-09-15.
//  Copyright (c) 2015 Boris Besemer. All rights reserved.
//

import UIKit

class UserListTableViewController: UITableViewController {
    var users = NSMutableArray()
    
    @IBAction func addUser(sender: AnyObject) {
        addNewUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func addNewUser() {
        LoadingOverlayController.sharedInstance.showOverlayView(navigationController?.view)
        RandomUserModel.sharedInstance.getRandomUser( { Void in
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView?.reloadData()
                LoadingOverlayController.sharedInstance.hideOverlayView()
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        let userCount = RandomUserModel.sharedInstance.users
        
        return userCount.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
        let items = RandomUserModel.sharedInstance.users
        let user: JSON = JSON(items[indexPath.row])
        
        let firstName = user["name"]["first"].string
        let lastName = user["name"]["last"].string
        
        // Configure the cell...
        cell.textLabel?.text = "\(firstName!.capitalizedString) \(lastName!.capitalizedString)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetailedView", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // if statement hell
        if segue.identifier == "showDetailedView" {
            if let destination = segue.destinationViewController as? SummaryViewController {
                if let indexPath = self.tableView.indexPathForSelectedRow() {
                    let person = indexPath.row
                    destination.userId = person
                }
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
