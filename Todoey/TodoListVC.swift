//
//  ViewController.swift
//  Todoey
//
//  Created by Stefan Milenkovic on 12/8/18.
//  Copyright © 2018 Stefan Milenkovic. All rights reserved.
//

import UIKit

class TodoListVC: UITableViewController {
    
    
    var todoListArray = ["Taks list", "Shopping list", "Learing list"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            todoListArray = items
        }
    }
    
    
    
    //MARK: - TableView DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        cell.textLabel?.text = todoListArray[indexPath.row]
        return cell
        
    }
    
    
    
    //MARK: - TableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    @IBAction func addItemTapped(_ sender: UIBarButtonItem) {
        
        var txtField = UITextField()
        
        let alert = UIAlertController(title: "Add new to do list", message: nil, preferredStyle: .alert)
        
        
        alert.addTextField { (textField) in
            
            textField.placeholder = "Enter new to do list"
            txtField = textField
   
        }
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            self.todoListArray.append(txtField.text!)
            
            self.defaults.setValue(self.todoListArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    


}

