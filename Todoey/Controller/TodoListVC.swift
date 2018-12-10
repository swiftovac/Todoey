//
//  ViewController.swift
//  Todoey
//
//  Created by Stefan Milenkovic on 12/8/18.
//  Copyright © 2018 Stefan Milenkovic. All rights reserved.
//

import UIKit
import CoreData

class TodoListVC: UITableViewController {
    
    
    var todoListArray = [Items]()
    
 
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        loadItems()
 
        
    }
    
    
    
    //MARK: - TableView DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        var item = todoListArray[indexPath.row]
 
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark: .none

        return cell
        
    }
    
    
    
    //MARK: - TableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        todoListArray[indexPath.row].done = !todoListArray[indexPath.row].done
        tableView.reloadData()
 
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

            var item = Items(context:self.context)
            item.title = txtField.text!
            item.done = false
            
            self.todoListArray.append(item)
            
            self.saveItems()
            
            
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func saveItems() {
 
        do{
            
            try context.save()
            
        }catch {
            
            print("Error saving item\(error)")
            
        }
        
    }
    
    
    func loadItems(with request: NSFetchRequest<Items> = Items.fetchRequest()) {
        
        do {
         try todoListArray = context.fetch(request)
         
        } catch{
            print("Error fetching data\(error)")
        }
 
    }
    


}

