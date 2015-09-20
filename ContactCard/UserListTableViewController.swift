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
        GetRandomUserController.sharedInstance.getRandomUser( { Void in
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            GetRandomUserController.sharedInstance.users.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        let userCount = GetRandomUserController.sharedInstance.users
        
        return userCount.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
        
        let items = GetRandomUserController.sharedInstance.users[indexPath.row]
        
        // Configure the cell...
        cell.textLabel?.text = items.mixedName
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetailedView", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // if statement hell
        if segue.identifier == "showDetailedView" {
            if let destination = segue.destinationViewController as? SummaryViewController {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    let person = indexPath.row
                    
                    destination.userId = person
                }
            }
        }
    }
}
