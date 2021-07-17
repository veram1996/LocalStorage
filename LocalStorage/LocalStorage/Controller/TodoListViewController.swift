//
//  ViewController.swift
//  LocalStorage
//
//  Created by Dheeraj Verma on 14/07/21.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray: [Item] =  []
    var dataFilePath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Itme.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        loadItems()
    }
    
}

extension TodoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text =  itemArray[indexPath.row].title
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !(itemArray[indexPath.row].done ?? false)
        self.saveItem()
        if  itemArray[indexPath.row].done ?? false {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func saveItem() {
        let encoder =  PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func loadItems() {
        if let data =  try? Data(contentsOf: dataFilePath!) {
            let decoder =  PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
            
        }
         
    }
}

extension TodoListViewController {
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert =  UIAlertController(title: "Add New Todory Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(Item(title: textfield.text ?? ""))
            self.saveItem()
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
