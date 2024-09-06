//
//  MainViewController.swift
//  ToDo List
//
//  Created by Руслан on 06.09.2024.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func showTodos(all: [Todo])
    func show(currentDate: String)
    func showTodos(open: [Todo])
    func showTodos(close: [Todo])
    func showCountTodos(all: Int, open: Int, close: Int)
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var closeLbl: UILabel!
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var closeCount: UILabel!
    @IBOutlet weak var openView: UIView!
    @IBOutlet weak var openLbl: UILabel!
    @IBOutlet weak var openCount: UILabel!
    @IBOutlet weak var allCount: UILabel!
    @IBOutlet weak var allView: UIView!
    @IBOutlet weak var allLbl: UILabel!
    
    @IBOutlet weak var currentDateLbl: UILabel!
    
    var presenter: MainPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    
    private func clearAllFilter() {
        closeLbl.textColor = UIColor.blackGray
        closeView.backgroundColor = UIColor.blackGray
        openLbl.textColor = UIColor.blackGray
        openView.backgroundColor = UIColor.blackGray
        allLbl.textColor = UIColor.blackGray
        allView.backgroundColor = UIColor.blackGray
    }
    
    private func selectedAll() {
        allLbl.textColor = UIColor.mainBlue
        allView.backgroundColor = UIColor.mainBlue
    }
    
    private func selectedOpen() {
        openLbl.textColor = UIColor.mainBlue
        openView.backgroundColor = UIColor.mainBlue
    }
    
    private func selectedClose() {
        closeLbl.textColor = UIColor.mainBlue
        closeView.backgroundColor = UIColor.mainBlue
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
        clearAllFilter()
        switch sender.tag {
        case 0:
            presenter?.clickAll()
            selectedAll()
        case 1:
            presenter?.clickOpen()
            selectedOpen()
        case 2:
            presenter?.clickClose()
            selectedClose()
        default:
            break
        }
    }
    
}
extension MainViewController: MainViewProtocol {
    
    func showCountTodos(all: Int, open: Int, close: Int) {
        DispatchQueue.main.async {
            self.allCount.text = "\(all)"
            self.openCount.text = "\(open)"
            self.closeCount.text = "\(close)"
        }
    }
    
    
    func showTodos(all: [Todo]) {
        print(all.count)
    }
    
    func showTodos(open: [Todo]) {
        print(open.count)
    }
    
    func showTodos(close: [Todo]) {
        print(close.count)
    }
    
    
    func show(currentDate: String) {
        DispatchQueue.main.async {
            self.currentDateLbl.text = currentDate
        }
    }
    
}
