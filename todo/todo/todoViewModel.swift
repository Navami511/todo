//
//  todoViewModel.swift
//  todo
//
//  Created by Navami Ajay on 31/10/23.
//

import Foundation
import CoreData
class todoViewModel: ObservableObject {
    var title: String = ""
    @Published var tasks: [TaskViewModel] = []
    
    
    
    func save(){
        let task = Task(context: CoreDataManager.shared.viewContext)
        task.title = title
        CoreDataManager.shared.save()
    }
    
    func getAllTasks() {
    tasks = CoreDataManager.shared.getAllTasks().map(TaskViewModel.init)
    }
    
    func delete(_task: TaskViewModel) {
        let existingTask = CoreDataManager.shared.getTaskById(id: _task.id)
        if let existingTask = existingTask {
            CoreDataManager.shared.deleteTask(task: existingTask)
        }
    }
}

struct TaskViewModel{
    let task: Task
    var id: NSManagedObjectID {
        return task.objectID
    }
    var title: String{
        return task.title ?? " "
    }
    
}
