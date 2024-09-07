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

struct TodoStruct {
    var id: Int
    var text: String
    var description: String
    var date: Date
    var completed: Bool
    var userID: Int
}

enum SelectedFilter {
    case all
    case open
    case close
}
