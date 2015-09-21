//
//  PersonModel.swift
//  ContactCard
//
//  Created by Boris Besemer on 11-09-15.
//  Copyright (c) 2015 Boris Besemer. All rights reserved.
//

import Foundation
import SwiftyJSON

class Person {
    let firstName: String?
    let lastName: String?
    let userImageUrl: String?
    var keyValues: [[String: String]]!
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
    
    func handlePersonData(user: JSON) {
        let currentUser = user
        
        for(key, subJson):(String, JSON) in currentUser {
        
            print("key is: \(key), value is: \(subJson)")
            if subJson != nil {
                let newItem = [key: subJson.string ?? ""]
                print(newItem)
                //keyValues.append(newItem)
            }
        }
    }
}