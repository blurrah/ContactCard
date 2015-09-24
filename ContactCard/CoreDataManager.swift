//
//  CoreDataManager.swift
//  ContactCard
//
//  Created by Boris Besemer on 22-09-15.
//  Copyright © 2015 Boris Besemer. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    class var sharedInstance: CoreDataManager {
        struct Singleton {
            static let instance = CoreDataManager()
        }
        return Singleton.instance
    }
    
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
    
    func getUsers() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        do {
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            // Set persons array to fetchedResults eg:
             RandomUserStore.sharedInstance.users =  fetchedResults!
        } catch let error as NSError {
            print("Was not able to fetch users: \(error.localizedDescription)")
        }
    }
    
    func addUser(user: Person) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        person.setValue(user.username, forKey: "username")
        person.setValue(user.firstName, forKey: "firstName")
        person.setValue(user.lastName, forKey: "lastName")
        person.setValue(user.userImage, forKey: "picture")
        person.setValue(user.dob, forKey: "dob")
        person.setValue(user.phone, forKey: "phone")
        person.setValue(user.cell, forKey: "cell")
        
        do {
            try managedContext.save()
            RandomUserStore.sharedInstance.users.append(person)
        } catch let error as NSError {
            print("Le error: \(error.localizedDescription)")
        }
    }
    
    func removeUser(id: Int) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let user = RandomUserStore.sharedInstance.users[id]
        
        managedContext.deleteObject(user)
        
        do {
            try managedContext.save()
            print("Removed item with id: \(id)")
        } catch let error as NSError {
            print("Deletion error: \(error.localizedDescription)")
        }
    }
}