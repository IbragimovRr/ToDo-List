//
//  MainModuleBuilder.swift
//  ToDo List
//
//  Created by Руслан on 06.09.2024.
//

import Foundation
import UIKit

class MainModuleBuilder {
    static func build() -> MainViewController {
        let interactor = MainInteractor()
        let router = MainRouter()
        let presenter = MainPresenter(interactor: interactor, router: router)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "Main") as! MainViewController
        interactor.presenter = presenter
        router.view = vc
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
}
