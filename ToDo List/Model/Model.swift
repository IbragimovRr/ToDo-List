//
//  Model.swift
//  ToDo List
//
//  Created by Руслан on 06.09.2024.
//

import Foundation


class Constant {
    static var urlTodoJson = "https://dummyjson.com/todos"
}

struct Todo {
    var id: Int
    var text: String
    var completed: Bool
    var userID: Int
}
