//
//  CoreDataMananger.swift
//  ToDo List
//
//  Created by Руслан on 08.09.2024.
//

import Foundation
import CoreData
import UIKit

class CoreDataMananger: NSObject {
    static let shared = CoreDataMananger()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func createTodo(_ todo: TodoStruct) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Todo", in: context) else { return }
        let todoData = Todo(entity: entity, insertInto: context)
        todoData.id = Int64(todo.id)
        todoData.text = todo.text
        todoData.descriptionText = todo.description
        todoData.completed = todo.completed
        todoData.date = todo.date
        todoData.userID = Int64(todo.userID)
        
        appDelegate.saveContext()
    }
    
    func getAllTodos() -> [Todo] {
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do {
            return try context.fetch(req) as! [Todo]
        }catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func changeTodo(todoStruct: TodoStruct) {
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do {
            guard let todos = try? context.fetch(req) as? [Todo],
                  let todo = todos.first(where: { $0.id == todoStruct.id }) else { return }
            todo.text = todoStruct.text
            todo.descriptionText = todoStruct.description
        }
        
        appDelegate.saveContext()
    }
    
    func completedTodo(id: Int64, completed: Bool) {
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do {
            guard let todos = try? context.fetch(req) as? [Todo],
                  let todo = todos.first(where: { $0.id == id }) else { return }
            todo.completed = completed
        }
        
        appDelegate.saveContext()
    }
}
