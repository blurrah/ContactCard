//
//  RandomUserModel.swift
//  ContactCard
//
//  Created by Boris Besemer on 03-09-15.
//  Copyright (c) 2015 Boris Besemer. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import CoreData

// New Class based on Core Data
class RandomUserStore {
    var users: [NSManagedObject] = []
    
    class var sharedInstance: RandomUserStore {
        struct Singleton {
            static let instance = RandomUserStore()
        }
        return Singleton.instance
    }
    
    func getStoredUsers() {
        CoreDataManager.sharedInstance.getUsers()
    }
    
    func getRandomUser(onCompletion: Void -> ()) {
        Alamofire.request(.GET, "https://randomuser.me/api/")
            .validate(statusCode: 200..<300)
            .responseJSON { (req, res, result) in
                switch result {
                case .Success(let data):
                    let jsonData = JSON(data)
                    let results = jsonData["results"]
                    
                    for (_, subJson) : (String, JSON) in results {
                        let user: AnyObject = subJson["user"].object
                        
                        CoreDataManager.sharedInstance.addUser(Person(person: user))
                        
                        //self.users.append(Person(person: user))
                    }
                    onCompletion()
                    
                case .Failure(_, let error):
                    print("Request failed with error: \(error)")
                }
        }

    }
}