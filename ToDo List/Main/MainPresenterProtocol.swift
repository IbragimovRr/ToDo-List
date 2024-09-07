//
//  MainPresenterProtocol.swift
//  ToDo List
//
//  Created by Руслан on 06.09.2024.
//

import Foundation
import UIKit

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didLoad(todos: [TodoStruct])
    func didDate(date: String)
    func clickOpen()
    func clickClose()
    func clickAll()
    func createTodo(text: String, description: String)
    func completedTodo(bool: Bool, id: Int)
    func changeTodo(todoStruct: TodoStruct)
}

class MainPresenter {
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol
    var router: MainRouterProtocol
    
    private var todos = [TodoStruct]()
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    private func getCloseTodos() -> [TodoStruct] {
        var closeTodos = [TodoStruct]()
        guard todos.isEmpty == false else { return [TodoStruct]() }
        for x in 0...todos.count - 1 {
            if todos[x].completed == true {
                closeTodos.append(todos[x])
            }
        }
        return closeTodos
    }
    
    private func getOpenTodos() -> [TodoStruct] {
        var openTodos = [TodoStruct]()
        guard todos.isEmpty == false else { return [TodoStruct]() }
        for x in 0...todos.count - 1 {
            if todos[x].completed == false {
                openTodos.append(todos[x])
            }
        }
        return openTodos
    }
    
}
extension MainPresenter: MainPresenterProtocol {
    
    // MARK: - Добавить
    
    func createTodo(text: String, description: String) {
        interactor.createTodo(text: text, description: description)
    }
    
    // MARK: - Изменить
    
    func changeTodo(todoStruct: TodoStruct) {
        interactor.changeTodo(todoStruct: todoStruct)
    }
    
    func completedTodo(bool: Bool, id: Int) {
        interactor.changeCompleted(bool: bool, id: id)
    }
    
    // MARK: - Получить
    
    func clickAll() {
        view?.showTodos(all: todos)
    }
    
    func clickOpen() {
        view?.showTodos(open: getOpenTodos())
    }
    
    func clickClose() {
        view?.showTodos(close: getCloseTodos())
    }
    
    func didDate(date: String) {
        view?.show(currentDate: date)
    }
    
    
    func didLoad(todos: [TodoStruct]) {
        self.todos = todos
        view?.showTodos(all: todos)
        view?.showCountTodos(all: todos.count , open: getOpenTodos().count, close: getCloseTodos().count)
    }
    
    
    func viewDidLoaded() {
        if UD().getCurrent() == false {
            interactor.fetchTodos()
            UD().saveCurrent(bool: true)
        }else {
            interactor.fetchTodosCoreData()
        }
        interactor.fetchCurrentData()
    }
    
}
