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

class RandomUserStore {
    var users: [Person] = Array()
    
    class var sharedInstance: RandomUserStore {
        struct Singleton {
            static let instance = RandomUserStore()
        }
        return Singleton.instance
    }
    
    func getRandomUser(onCompletion: Void -> ()) {
        Alamofire.request(.GET, "https://randomuser.me/api/")
            .responseJSON { (req, res, result) in
                switch result {
                    case .Success(let data):
                        let jsonData = JSON(data)
                        let results = jsonData["results"]
                        
                        for (_, subJson) : (String, JSON) in results {
                            let user: AnyObject = subJson["user"].object
                        
                            self.users.append(Person(person: user))
                        }
                        onCompletion()
                    
                        case .Failure(_, let error):
                            print("Request failed with error: \(error)")
                }
        }
    }
}

