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
    
    let users = NSMutableArray()
    var firstName: String?
    var lastName: String?
    var fullName: String {
        get {
            return firstName!.capitalizedString + " " + lastName!.capitalizedString
        }
    }
    
    func getRandomUser(onCompletion: Void -> ()) {
        RestApiManager.sharedInstance.getRandomUser { json in
            let results = json["results"]
            
            for (index: String, subJson: JSON) in results {
                let user: AnyObject = subJson["user"].object
                
                self.users.addObject(user)
                
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

protocol RandomUserModelDelegate {
    func loadingRandomUserDidStart(instance: RandomUserModel)
    func loadingRandomUserDidEnd(instance: RandomUserModel)
}

