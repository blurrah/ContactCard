//
//  PersonModel.swift
//  ContactCard
//
//  Created by Boris Besemer on 11-09-15.
//  Copyright (c) 2015 Boris Besemer. All rights reserved.
//

import Foundation
import SwiftyJSON

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

class Person {
    let username: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let gender: String?
    let userImageUrl: String?
    let dob: Double?
    let phone: String?
    let cell: String?
    var mixedName: String {
        get {
            return firstName!.capitalizedString + " " + lastName!.capitalizedString
        }
    }
    
    var userImage: NSData {
        get {
            let url: NSURL = NSURL(string: userImageUrl!)!
            let data: NSData = NSData(contentsOfURL: url)!
            
            return data
        }
    }
    
    var dateofbirth: NSDate {
        return NSDate(timeIntervalSince1970: dob!)
    }
    
    init(person: AnyObject?) {
        var user = JSON(person!)
        
        username = user["username"].string!
        firstName = user["name"]["first"].string!
        lastName = user["name"]["last"].string!
        email = user["email"].string!
        gender = user["gender"].string!
        userImageUrl = user["picture"]["medium"].string!
        dob = user["dob"].doubleValue
        phone = user["phone"].string!
        cell = user["cell"].string!
    }
}