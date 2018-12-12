//
//  CategoryVC.swift
//  Todoey
//
//  Created by Stefan Milenkovic on 12/10/18.
//  Copyright © 2018 Stefan Milenkovic. All rights reserved.
//

import UIKit
import CoreData

class CategoryVC: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategoryes()


    }
    
    //MARK: - TableView Data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    
    
    //MARK: - TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TodoListVC
        
        if let indexPath = tableView.indexPathForSelectedRow {
        
            destination.selectedCategory = categoryArray[indexPath.row]
            
        }
    }
    
    //MARK: - CoreData stuff
    

    @IBAction func addCategoryTapped(_ sender: Any) {
        
        var txtField = UITextField()
        
        let alert = UIAlertController(title: "Enter category", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            
            txtField = textField
            textField.placeholder = "Add category"
            
        }
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            
            let cat = Category(context: self.context)
            cat.name = txtField.text!
            self.categoryArray.append(cat)
            
            
            self.saveCategory()
            self.tableView.reloadData()
            
            
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
   
        
    }
    
    
    
    
    func saveCategory() {
        
        do{
            try context.save()
        }catch{
            
            print("Error saving category\(error)")
        }
        
        
    }
    
    
    
    
    func loadCategoryes() {
        
        let req: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            try categoryArray = context.fetch(req)
        }catch{
            print("Error fetching categoryes\(error)")
        }
        
    }
    
}



