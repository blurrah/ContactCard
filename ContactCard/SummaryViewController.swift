//
//  SummaryViewController.swift
//  ContactCard
//
//  Created by Boris Besemer on 31-08-15.
//  Copyright (c) 2015 Boris Besemer. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    
    // IB Outlets
    @IBOutlet var userImageOutlet: UIImageView!
    @IBOutlet var mixedNameOutlet: UILabel!
    @IBOutlet var emailOutlet: UILabel!
    @IBOutlet var genderOutlet: UILabel!
    @IBOutlet var dobOutlet: UILabel!
    @IBOutlet var phoneOutlet: UILabel!
    @IBOutlet var cellPhoneOutlet: UILabel!
    
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
    
    /* Entity:
    @username: String
    @firstName: String
    @lastName: String
    @email: String
    @gender: String
    @picture: Binary Data
    @dob: Date
    @phone: String
    @cell: String
    */
    
    
    func loadModelData() {
        // Big function cuz stuff
        let user = RandomUserStore.sharedInstance.users[userId!]
        let username = user.valueForKey("username") as! String
        let firstName = user.valueForKey("firstName") as! String
        let lastName = user.valueForKey("lastName") as! String
        let email = user.valueForKey("email") as! String
        let gender = user.valueForKey("gender") as! String
        let picture:NSData = (user.valueForKey("picture") as? NSData)!
        let dob = user.valueForKey("dob") as! NSDate
        let phone = user.valueForKey("phone") as! String
        let cell = user.valueForKey("cell") as! String
        
        self.mixedNameOutlet.text = "\(firstName.capitalizedString) \(lastName.capitalizedString) (\(username))"
        self.userImageOutlet.image = UIImage(data: picture)
        self.emailOutlet.text = email
        self.genderOutlet.text = gender
        
        // set up NSDate time stuff
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/M/yyyy"
        let dateString = dateFormatter.stringFromDate(dob)
        self.dobOutlet.text = dateString
        
        self.phoneOutlet.text = phone
        self.cellPhoneOutlet.text = cell
        
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
