//
//  RandomUserModel.swift
//  ContactCard
//
//  Created by Boris Besemer on 03-09-15.
//  Copyright (c) 2015 Boris Besemer. All rights reserved.
//

import Foundation

protocol GetRandomUserDelegate {
    func loadingRandomUserDidStart(instance: GetRandomUserController)
    func loadingRandomUserDidEnd(instance: GetRandomUserController)
}

class GetRandomUserController {
    class var sharedInstance: GetRandomUserController {
        struct Singleton {
            static let instance = GetRandomUserController()
        }
        return Singleton.instance
    }
    
    var users: [Person] = Array()
    
    func getRandomUser(onCompletion: Void -> ()) {
        RestApiManager.sharedInstance.getRandomUser { json in
            let results = json["results"]
            
            for (index: String, subJson: JSON) in results {
                let user: AnyObject = subJson["user"].object
                
                self.users.append(Person(person: user))
                
                onCompletion()
            }
        }
    }
    
}
