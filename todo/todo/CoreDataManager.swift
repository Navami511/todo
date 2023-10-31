//
//  CoreDataManager.swift
//  todo
//
//  Created by Navami Ajay on 31/10/23.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager() // since init is private, to access its members we use the static instance of coredatamanager called 'shared'
    
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "ToDoAppModel")
        persistentContainer.loadPersistentStores {(description, error) in
            if let error = error {
                fatalError("unable to initialize core data stack \(error)")
            }
        }
    }
    
    func save() {
        do{
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func getAllTasks() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
          return[]
        }
    }
    
    func getTaskById(id: NSManagedObjectID) -> Task?{
        do{
            return try viewContext.existingObject(with: id) as? Task
        }catch {
            return nil
        }
        
    }
    
    func deleteTask(task: Task) {
        viewContext.delete(task)
        save()
    }
    
}

