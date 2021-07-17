//
//  ViewController.swift
//  LocalStorage
//
//  Created by Dheeraj Verma on 14/07/21.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray: [String] =  []
    var defaults =  UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        itemArray =  defaults.array(forKey: "TodoListArray") as? [String] ?? []
        // Do any additional setup after loading the view.
    }
   
}

extension TodoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text =  itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TodoListViewController {
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert =  UIAlertController(title: "Add New Todory Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textfield.text ?? "")
            self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Create new item"
            textfield = textField
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
