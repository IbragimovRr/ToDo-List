//
//  MainViewController.swift
//  ToDo List
//
//  Created by Руслан on 06.09.2024.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func show(currentDate: String)
    func showTodos(all: [TodoStruct])
    func showTodos(open: [TodoStruct])
    func showTodos(close: [TodoStruct])
    func showCountTodos(all: Int, open: Int, close: Int)
    func showChangeTodo(index: Int, text: String)
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var todosTableView: UITableView!
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
    var todos = [TodoStruct]()
    private var selectedFilter = SelectedFilter.all

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        todosTableView.delegate = self
        todosTableView.dataSource = self
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
        presenter?.clickAll()
        allLbl.textColor = UIColor.mainBlue
        allView.backgroundColor = UIColor.mainBlue
        selectedFilter = .all
    }
    
    private func selectedOpen() {
        presenter?.clickOpen()
        openLbl.textColor = UIColor.mainBlue
        openView.backgroundColor = UIColor.mainBlue
        selectedFilter = .open
    }
    
    private func selectedClose() {
        presenter?.clickClose()
        closeLbl.textColor = UIColor.mainBlue
        closeView.backgroundColor = UIColor.mainBlue
        selectedFilter = .close
    }
    
    private func checkSelected() {
        presenter?.viewDidLoaded()
        switch selectedFilter {
        case .all:
            presenter?.clickAll()
        case .open:
            presenter?.clickOpen()
        case .close:
            presenter?.clickClose()
        }
    }
    
    func changeAlert(index: Int) {
        let alert = UIAlertController(title: "Изменить", message: "Впишите TODO", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = self.todos[index].text
        }
        alert.addTextField { textField in
            textField.text = self.todos[index].description
        }
        alert.addAction(UIAlertAction(title: "Изменить", style: .default, handler: { [weak self] _ in
            self!.todos[index].text = alert.textFields![0].text!
            self!.todos[index].description = alert.textFields![1].text!
            self?.presenter?.changeTodo(todoStruct: self!.todos[index])
            self?.checkSelected()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func createAlert() {
        let alert = UIAlertController(title: "Создать", message: "Впишите TODO", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Главный текст"
        }
        alert.addTextField { textField in
            textField.placeholder = "Описание"
        }
        alert.addAction(UIAlertAction(title: "Создать", style: .default, handler: { [weak self] _ in
            self?.presenter?.createTodo(text: alert.textFields![0].text!, description:  alert.textFields![1].text!)
            self?.checkSelected()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func createTodo(_ sender: UIButton) {
        createAlert()
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
        clearAllFilter()
        switch sender.tag {
        case 0:
            selectedAll()
        case 1:
            selectedOpen()
        case 2:
            selectedClose()
        default:
            break
        }
    }
    
}
extension MainViewController: MainViewProtocol {
    
    func showChangeTodo(index: Int, text: String) {
        todos[index].text = text
        todosTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    
    func showCountTodos(all: Int, open: Int, close: Int) {
        DispatchQueue.main.async {
            self.allCount.text = "\(all)"
            self.openCount.text = "\(open)"
            self.closeCount.text = "\(close)"
        }
    }
    
    
    func showTodos(all: [TodoStruct]) {
        todos = all
        DispatchQueue.main.async {
            self.todosTableView.reloadData()
        }
    }
    
    func showTodos(open: [TodoStruct]) {
        todos = open
        todosTableView.reloadData()
    }
    
    func showTodos(close: [TodoStruct]) {
        todos = close
        todosTableView.reloadData()
    }
    
    
    func show(currentDate: String) {
        DispatchQueue.main.async {
            self.currentDateLbl.text = currentDate
        }
    }
    
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Main", for: indexPath) as! MainTableViewCell
        cell.selectedBtn.addTarget(self, action: #selector(selected), for: .touchUpInside)
        cell.selectedBtn.tag = indexPath.row
        cell.mainText.text = todos[indexPath.row].text
        cell.descripionText.text = todos[indexPath.row].description
        cell.selectBtn(bool: todos[indexPath.row].completed)
        return cell
    }
    

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let defaultRowAction = UITableViewRowAction(style: .normal, title: "Изменить", handler: { action, indexpath in
            self.changeAlert(index: indexPath.row)
        })
        
        
        let deleteRowAction = UITableViewRowAction(style: .destructive, title: "Удалить", handler: { action, indexpath in
            self.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        });
        return [deleteRowAction, defaultRowAction];
    }
    
    
    @objc func selected(sender: UIButton) {
        todos[sender.tag].completed.toggle()
        presenter?.completedTodo(bool: todos[sender.tag].completed, id: todos[sender.tag].id)
        checkSelected()
        todosTableView.reloadData()
    }
    
}
