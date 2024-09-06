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
    
    @IBOutlet weak var collectionView: UICollectionView!
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
    var todos = [Todo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        collectionView.delegate = self
        collectionView.dataSource = self
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
        todos = all
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showTodos(open: [Todo]) {
        todos = open
        collectionView.reloadData()
    }
    
    func showTodos(close: [Todo]) {
        todos = close
        collectionView.reloadData()
    }
    
    
    func show(currentDate: String) {
        DispatchQueue.main.async {
            self.currentDateLbl.text = currentDate
        }
    }
    
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Main", for: indexPath) as! MainCollectionViewCell
        cell.selectedBtn.tag = indexPath.row
        cell.mainText.text = todos[indexPath.row].text
        cell.selectBtn(bool: todos[indexPath.row].completed)
        cell.selectedBtn.addTarget(self, action: #selector(selected), for: .touchUpInside)
        return cell
    }
    
    @objc func selected(sender: UIButton) {
        if todos[sender.tag].completed {
            todos[sender.tag].completed = false
        }else {
            todos[sender.tag].completed = true
        }
        collectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
    }
    
}
