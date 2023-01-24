//
//  FavoriteCoreDataManager.swift
//  GameStore
//
//  Created by Melih Yuvacı on 21.01.2023.
//

import Foundation
import CoreData

class FavoriteCoreDataManager {
    
    static let shared = FavoriteCoreDataManager()
    
    private init (){}
    
    //MARK: - Fetch Items
    
    func getAllFavorites () -> [Favorites] {
        let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        let secondSort = NSSortDescriptor(key: #keyPath(Favorites.name), ascending: false)
        request.sortDescriptors = [secondSort]
        var items = [Favorites]()
        do {
            items = try persistentContainer.viewContext.fetch(request)
        } catch let err {
            print(err.localizedDescription)
        }
        
        return items
    }
    //MARK: - Save Items
    
    func saveFavorites(name: String, favorite: Bool,  completion: @escaping (Bool) -> Void) {
        let items = Favorites(context: persistentContainer.viewContext)
        items.id = UUID()
        items.name = name
        items.favorited = favorite
        saveContext()
        completion(true)
    }
    
    //MARK: - Delete Items
    
    func deleteFavorites(item : Favorites, completion: @escaping (Bool) -> Void) {
        let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        request.predicate = NSPredicate(format: Constants.Favorites.CoreDataManager.predicateFormat,item.id!.uuidString)
        
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
    
   
    
   
    //MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.Favorites.CoreDataManager.persistantContainerName)
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
