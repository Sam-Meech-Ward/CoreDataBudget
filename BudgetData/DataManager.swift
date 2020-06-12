//
//  DataManager.swift
//  BudgetData
//
//  Created by Sam Meech-Ward on 2020-06-11.
//  Copyright © 2020 meech-ward. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
  
  static let shared = DataManager()
  
  lazy var persistentContainer: NSPersistentContainer = {
       /*
        The persistent container for the application. This implementation
        creates and returns a container, having loaded the store for the
        application to it. This property is optional since there are legitimate
        error conditions that could cause the creation of the store to fail.
       */
       let container = NSPersistentContainer(name: "BudgetData")
       container.loadPersistentStores(completionHandler: { (storeDescription, error) in
           if let error = error as NSError? {
               // Replace this implementation with code to handle the error appropriately.
               // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
               /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
               fatalError("Unresolved error \(error), \(error.userInfo)")
           }
       })
       return container
   }()
  
  func budget(title: String, amount: NSDecimalNumber) -> Budget {
    let budg = Budget(context: persistentContainer.viewContext)
    budg.title = title
    budg.amount = amount
    return budg
  }
  
  func expense(name: String, amount: NSDecimalNumber, budget: Budget) -> Expense {
    let exp = Expense(context: persistentContainer.viewContext)
    exp.name = name
    exp.amount = amount
    exp.budget = budget
    exp.timestamp = Date()
    return exp
  }
  
  func budgets() -> [Budget] {
    let request: NSFetchRequest<Budget> = Budget.fetchRequest()
    
    var fetchedBudgets: [Budget] = []
    
    do {
      fetchedBudgets = try persistentContainer.viewContext.fetch(request)
    } catch {
      print("Error fetching budgets")
    }
    
    return fetchedBudgets
  }
  
  func expenses(budget: Budget) -> [Expense] {
    let request: NSFetchRequest<Expense> = Expense.fetchRequest()
    
    request.predicate = NSPredicate(format: "(amount > 0) AND (budget = %@)", budget)
    
    request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
    
    var fetched: [Expense] = []
    
    do {
      fetched = try persistentContainer.viewContext.fetch(request)
    } catch {
      print("Error fetching budgets")
    }
    
    return fetched
  }

   // MARK: - Core Data Saving support

   func save () {
       let context = persistentContainer.viewContext
       if context.hasChanges {
           do {
               try context.save()
           } catch {
               // Replace this implementation with code to handle the error appropriately.
               // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
               let nserror = error as NSError
               fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
           }
       }
   }
  
}
