//
//  PersonModel.swift
//  ContactCard
//
//  Created by Boris Besemer on 11-09-15.
//  Copyright (c) 2015 Boris Besemer. All rights reserved.
//

import Foundation

class Person {
    let firstName: String?
    let lastName: String?
    let userImageUrl: String?
    var userImage: NSData {
        get {
            let url: NSURL = NSURL(string: userImageUrl!)!
            let data: NSData = NSData(contentsOfURL: url)!
            
            return data
        }
    }
    var mixedName: String {
        get {
            return firstName!.capitalizedString + " " + lastName!.capitalizedString
        }
    }
    
    init(person: AnyObject?) {
        var user = JSON(person!)
        
        firstName = user["name"]["first"].string!
        lastName = user["name"]["last"].string!
        userImageUrl = user["picture"]["medium"].string!
        
    }
}