//
//  MainPresenterProtocol.swift
//  ToDo List
//
//  Created by Руслан on 06.09.2024.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

class MainPresenter {
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol
    var router: MainRouterProtocol
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
}
extension MainPresenter: MainPresenterProtocol {
    func viewDidLoaded() {
        <#code#>
    }
    
    
}
