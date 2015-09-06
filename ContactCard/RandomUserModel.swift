//
//  RandomUserModel.swift
//  ContactCard
//
//  Created by Boris Besemer on 03-09-15.
//  Copyright (c) 2015 Boris Besemer. All rights reserved.
//

import Foundation

class RandomUserModel {
    
    // User variables
    class var sharedInstance: RandomUserModel {
        struct Singleton {
            static let instance = RandomUserModel()
        }
        
        return Singleton.instance
    }
    
    let users: NSMutableArray = NSMutableArray()
    var firstName: String?
    var lastName: String?
    var fullName: String {
        get {
            return firstName! + " " + lastName!
        }
    }
    
    func getRandomUser(onCompletion: Void -> ()) {
        RestApiManager.sharedInstance.getRandomUser { json in
            let results = json["results"]
            
            for (index: String, subJson: JSON) in results {
                self.users[0] = subJson["user"].object
                
                self.handleUserReceived()
                onCompletion()
            }
        }
    }
    
    func handleUserReceived() {
        let userJson: JSON = JSON(self.users[0])
        
        self.firstName = userJson["name"]["first"].stringValue
        self.lastName = userJson["name"]["last"].stringValue
    }
    
    
    
}

