//
//  RestAPIManager.swift
//  ContactCard
//
//  Created by Boris Besemer on 03-09-15.
//  Copyright (c) 2015 Boris Besemer. All rights reserved.
//  RestAPI Manager based on http://devdactic.com/rest-api-parse-json-swift/
//

import Foundation
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    class var sharedInstance: RestApiManager {
        struct Singleton {
            static let instance = RestApiManager()
        }
        return Singleton.instance
    }
    
    let baseUrl = "https://randomuser.me/api/"
    
    func getRandomUser(onCompletion: (JSON) -> Void) {
        let route = baseUrl
        
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string:path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data!)
            onCompletion(json, error)
        })
        task.resume()
    }
}

