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
}

class MainInteractor {
    weak var presenter: MainPresenterProtocol?
    
}

extension MainInteractor: MainInteractorProtocol {
    
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
            
            var todos = [Todo]()
            let count = json["todos"].arrayValue.count
            
            for x in 0...count - 1 {
                let id = json["todos"][x]["id"].intValue
                let text = json["todos"][x]["todo"].stringValue
                let completed = json["todos"][x]["completed"].boolValue
                let userID = json["todos"][x]["userId"].intValue
                let todo = Todo(id: id, text: text, completed: completed, userID: userID)
                todos.append(todo)
            }
            presenter?.didLoad(todos: todos)
        }
    }

}
