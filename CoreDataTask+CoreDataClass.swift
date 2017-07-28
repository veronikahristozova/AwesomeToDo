//
//  CoreDataTask+CoreDataClass.swift
//  AwesomeToDo
//
//  Created by Veronika Hristozova on 7/28/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import CoreData
import UIKit

@objc(CoreDataTask)
public class CoreDataTask: NSManagedObject {

    @NSManaged public var title: String?
    @NSManaged public var categoryName: String?
    @NSManaged public var categoryColor: Int64
    @NSManaged public var date: String?
    @NSManaged public var isCompleted: Bool
    
    static let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataTask")
    static let maxTasksCount = 1000
    
    // MARK: - Get Managed Context
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let coordinator = appDelegate.persistentContainer.persistentStoreCoordinator
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }
    
    // MARK: - Load Tasks
    static func loadTasks() -> [CoreDataTask] {
        let managedContext = getContext()
        
        do {
            return try managedContext.fetch(request) as? [CoreDataTask] ?? [CoreDataTask]()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return []
    }
    
    
    // MARK: - Save Task
    static func saveTask(title: String, categoryName: String, categoryColor: Int64, date: String, isCompleted: Bool) {
        let tasks = loadTasks()
        
        if let entity = NSEntityDescription.entity(forEntityName: "CoreDataTask", in: getContext()) {
            let task = NSManagedObject(entity: entity, insertInto: getContext())
            
            task.setValue(title, forKey: "title")
            task.setValue(categoryName, forKey: "categoryName")
            task.setValue(categoryColor, forKey: "categoryColor")
            task.setValue(date, forKey: "date")
            task.setValue(isCompleted, forKey: "isCompleted")
            
            do {
                try getContext().save()
            } catch let error {
                print("Could not save \(error)")
            }
            
            
            if tasks.count >= maxTasksCount {
                do {
                    let results = try getContext().fetch(request)
                    getContext().delete(results.first as! NSManagedObject)
                    do {
                        try getContext().save()
                    } catch let error {
                        print("Could not save \(error)")
                    }
                } catch let error {
                    print("Delete single data in CoreDataTask error: \(error)")
                }
            }
        }
    }
    
    // MARK: - Delete Task
    static func deleteTask(title: String) {
        let managedContext = getContext()
        do {
            let results = try managedContext.fetch(request)
            for managedObject in results
            {
                if (managedObject as AnyObject).title == title {
                    let managedObjectData = managedObject as! NSManagedObject
                    managedContext.delete(managedObjectData)
                    do {
                        try managedContext.save()
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                }
            }
        } catch let error as NSError {
            print("Delete data in CartItems error : \(error) \(error.userInfo)")
        }
        
    }
    
    
    
}
