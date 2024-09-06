//
//  MainViewController.swift
//  ToDo List
//
//  Created by Руслан on 06.09.2024.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    
}

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
extension MainViewController: MainViewProtocol {
    
}
