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
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var todoListArray = [Items]()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
 
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        

        
    }
    
    
    
    //MARK: - TableView DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        let item = todoListArray[indexPath.row]
 
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

            let item = Items(context:self.context)
            item.title = txtField.text!
            item.done = false
            item.parentCategory = self.selectedCategory
            
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
    
    
    func loadItems(with request: NSFetchRequest<Items> = Items.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate: NSPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let aditionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, aditionalPredicate])
            
        }else {
            request.predicate = categoryPredicate
        }
        

        
        do {
         try todoListArray = context.fetch(request)
         
        } catch{
            print("Error fetching data\(error)")
        }
        
        tableView.reloadData()
 
    }
    


}

extension TodoListVC: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let req: NSFetchRequest<Items> = Items.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        req.predicate = predicate
        let sortDesciptor = NSSortDescriptor(key: "title", ascending: true)
        req.sortDescriptors = [sortDesciptor]
        
        loadItems(with: req, predicate: predicate)
        
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == 0 {
            
            loadItems()
            tableView.reloadData()
            
            
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()
  
            }
            
        }
        
    }
    
    
}

