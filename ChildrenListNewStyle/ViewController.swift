//
//  ViewController.swift
//  ChildrenListNewStyle
//
//  Created by Дэлина Дворжецкая on 25.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var personsChildren = [Child]()
    
    @IBAction func deleteButtonPressed() {
        actionSheet()
    }
    
    @IBAction func addChildButtonPressed() {
        addChild()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        personsChildren.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ChildCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChildCell
        
        let child = personsChildren[indexPath.row]
        
        cell.childNameTF.text = child.name
        cell.childNameTF.tag = indexPath.row
        cell.childNameTF.addTarget(self, action: #selector(changeChildName(_:)), for: .editingChanged)
        
        cell.childAgeTF.text = child.age
        cell.childAgeTF.tag = indexPath.row
        cell.childAgeTF.addTarget(self, action: #selector(changeChildAge(_:)), for: .editingChanged)
        
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteButton(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func deleteButton(_ sender: UIButton) {
        personsChildren.remove(at: sender.tag)
        tableView.reloadData()
        
        if personsChildren.count < 5 {
            addButton.alpha = 1
        }
    }
    
    @objc func changeChildName(_ sender: UITextField) {
        personsChildren[sender.tag].name = sender.text
    }
    
    @objc func changeChildAge(_ sender: UITextField) {
        personsChildren[sender.tag].age = sender.text
    }
}

extension ViewController {
    
    private func actionSheet() {
        let actionSheet = UIAlertController(title: "Очистка данных", message: "Вы действительно хотите очистить данные?", preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Сбросить данные", style: .default) { _ in
            self.personsChildren.removeAll()
            self.tableView.reloadData()
            
            self.nameTF.text = ""
            self.ageTF.text = ""
            
            self.addButton.alpha = 1
        }
        let noAction = UIAlertAction(title: "Отмена", style: .cancel)
        actionSheet.addAction(yesAction)
        actionSheet.addAction(noAction)
        
        present(actionSheet, animated: true)
    }
    
    private func addChild() {
        personsChildren.append(Child(name: nil, age: nil))
        self.tableView.reloadData()
        
        if personsChildren.count >= 5 {
            self.addButton.alpha = 0
        }
    }
}
