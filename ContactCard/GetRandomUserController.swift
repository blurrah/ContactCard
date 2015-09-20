//
//  RandomUserModel.swift
//  ContactCard
//
//  Created by Boris Besemer on 03-09-15.
//  Copyright (c) 2015 Boris Besemer. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol GetRandomUserDelegate {
    func loadingRandomUserDidStart(instance: GetRandomUserController)
    func loadingRandomUserDidEnd(instance: GetRandomUserController)
}

class GetRandomUserController {
    var users: [Person] = Array()
    
    class var sharedInstance: GetRandomUserController {
        struct Singleton {
            static let instance = GetRandomUserController()
        }
        return Singleton.instance
    }
    
    func getRandomUser(onCompletion: Void -> ()) {
        RestApiManager.sharedInstance.getRandomUser { json in
            let results = json["results"]
            
            for (_, subJson): (String, JSON) in results {
                let user: AnyObject = subJson["user"].object
                
                self.users.append(Person(person: user))
                
                onCompletion()
            }
        }
    }
}

