//
//  MainInteractorProtocol.swift
//  ToDo List
//
//  Created by Руслан on 06.09.2024.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol MainInteractorProtocol: AnyObject {
    func fetchTodos()
    func fetchCurrentData()
    func fetchTodosCoreData()
    func createTodo(text: String, description: String)
    func changeCompleted(bool: Bool, id: Int)
    func changeTodo(todoStruct: TodoStruct)
}

class MainInteractor {
    weak var presenter: MainPresenterProtocol?
    
    private func todoInStruct(todos: [Todo]) -> [TodoStruct] {
        var todosResult = [TodoStruct]()
        for x in todos {
            todosResult.append(TodoStruct(id: Int(x.id), text: x.text!, description: x.descriptionText!, date: x.date, completed: x.completed, userID: Int(x.userID)))
        }
        return todosResult
    }
    
}

extension MainInteractor: MainInteractorProtocol {
    
    func changeTodo(todoStruct: TodoStruct) {
        CoreDataMananger.shared.changeTodo(todoStruct: todoStruct)
    }
    
    
    func changeCompleted(bool: Bool, id: Int) {
        CoreDataMananger.shared.completedTodo(id: Int64(id), completed: bool)
    }
    
    func createTodo(text: String, description: String) {
        let id = Int.random(in: 0...10000000)
        CoreDataMananger.shared.createTodo(TodoStruct(id: id, text: text, description: description, date: Date(), completed: false, userID: 0))
    }
    
    
    func fetchTodosCoreData() {
        let todos = CoreDataMananger.shared.getAllTodos()
        presenter?.didLoad(todos: todoInStruct(todos: todos))
    }
    
    
    
    func fetchCurrentData() {
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMMM"

        let formattedDateString = dateFormatter.string(from: currentDate)
        presenter?.didDate(date: formattedDateString)
    }
    
    
    func fetchTodos() {
        Task {
            let url = Constant.urlTodoJson
            
            let value = try await AF.request(url, method: .get).serializingData().value
            let json = JSON(value)
            
            var todos = [TodoStruct]()
            let count = json["todos"].arrayValue.count
            
            for x in 0...count - 1 {
                let id = json["todos"][x]["id"].intValue
                let text = json["todos"][x]["todo"].stringValue
                let completed = json["todos"][x]["completed"].boolValue
                let userID = json["todos"][x]["userId"].intValue
                let todo = TodoStruct(id: id, text: text, description: "Crypto Wallet Redesign", date: Date(), completed: completed, userID: userID)
                todos.append(todo)
            }
            presenter?.didLoad(todos: todos)
        }
    }

}
