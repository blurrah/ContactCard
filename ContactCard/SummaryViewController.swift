//
//  SummaryViewController.swift
//  ContactCard
//
//  Created by Boris Besemer on 31-08-15.
//  Copyright (c) 2015 Boris Besemer. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController, UITableViewDataSource {
    
    // IB Outlets
    @IBOutlet var userImageOutlet: UIImageView!
    @IBOutlet var mixedNameOutlet: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var items: NSMutableArray = NSMutableArray()
    var userId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userImageOutlet.layer.cornerRadius = userImageOutlet.frame.width / 2.0
        userImageOutlet.layer.borderColor = UIColor.whiteColor().CGColor
        userImageOutlet.layer.borderWidth = 5.0
        userImageOutlet.clipsToBounds = true
        
        // Load data
        loadModelData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadModelData() {
        let user = GetRandomUserController.sharedInstance.users[userId!]
        
        let picture:NSData = user.userImage
        
        self.mixedNameOutlet.text = user.mixedName
        self.userImageOutlet.image = UIImage(data: picture)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        let user:JSON = JSON(self.items[indexPath.row])
        
        cell.textLabel?.text = user["username"].stringValue
        cell.detailTextLabel?.text = "Is de username van de gebruiker"
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
