//
//  MainInteractorProtocol.swift
//  ToDo List
//
//  Created by Руслан on 06.09.2024.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    
}

class MainInteractor {
    weak var presenter: MainPresenterProtocol?
}

extension MainInteractor: MainInteractorProtocol {
    
}
