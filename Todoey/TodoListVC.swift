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

    override func viewDidLoad() {
        super.viewDidLoad()
        
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


}

