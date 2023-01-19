//
//  CoreDataManager.swift
//  GameStore
//
//  Created by Melih Yuvacı on 20.01.2023.
//

import Foundation
import CoreData

class CoreDataManager{
    static let shared = CoreDataManager()
    
    private init (){}
    
    func deleteTask(item : Notes, completion: @escaping (Bool) -> Void) {
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", item.id!.uuidString)
        
        do {
            let context = persistentContainer.viewContext
            let result = try context.fetch(request)
            if result.count > 0 {
                let item = result.first!
                context.delete(item)
                saveContext()
                completion(true)
            }
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func completeTask(item : Notes, completion: @escaping (Bool) -> Void) {
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", item.id!.uuidString)
        
        do {
            let result = try persistentContainer.viewContext.fetch(request)
            if result.count > 0 {
                let item = result.first!
//                todo.completedTask = true
//                todo.completedOn = Date()
                saveContext()
                completion(true)
            }
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func getAllTodos () -> [Notes] {
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        let firstSort = NSSortDescriptor(key: #keyPath(Notes.name), ascending: true)
        let secondSort = NSSortDescriptor(key: #keyPath(Notes.comment), ascending: false)
        request.sortDescriptors = [firstSort, secondSort]
        var items = [Notes]()
        
        do {
            items = try persistentContainer.viewContext.fetch(request)
        } catch let err {
            print(err.localizedDescription)
        }
        
        return items
    }
    
    func saveToDo(name: String, comment: String, completion: @escaping (Bool) -> Void) {
        let items = Notes(context: persistentContainer.viewContext)
        items.id = UUID()
        items.name = name
        items.comment = comment
        saveContext()
        completion(true)
    }
    
    //MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
