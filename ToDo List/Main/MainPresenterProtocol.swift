//
//  MainPresenterProtocol.swift
//  ToDo List
//
//  Created by Руслан on 06.09.2024.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didLoad(todos: [Todo])
    func didDate(date: String)
    func clickOpen()
    func clickClose()
    func clickAll()
}

class MainPresenter {
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol
    var router: MainRouterProtocol
    
    private var todos = [Todo]()
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    private func getCloseTodos() -> [Todo] {
        var closeTodos = [Todo]()
        guard todos.isEmpty == false else { return [Todo]() }
        for x in 0...todos.count - 1 {
            if todos[x].completed == true {
                closeTodos.append(todos[x])
            }
        }
        return closeTodos
    }
    
    private func getOpenTodos() -> [Todo] {
        var openTodos = [Todo]()
        guard todos.isEmpty == false else { return [Todo]() }
        for x in 0...todos.count - 1 {
            if todos[x].completed == false {
                openTodos.append(todos[x])
            }
        }
        return openTodos
    }
    
}
extension MainPresenter: MainPresenterProtocol {
    
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
    
    
    func didLoad(todos: [Todo]) {
        self.todos = todos
        view?.showTodos(all: todos)
        view?.showCountTodos(all: todos.count , open: getOpenTodos().count, close: getCloseTodos().count)
    }
    
    
    func viewDidLoaded() {
        if UD().getCurrent() == false {
            interactor.fetchTodos()
            UD().saveCurrent(bool: true)
        }else {
            // CoreData
        }
        interactor.fetchCurrentData()
    }
    
}
