//
//  CategoryViewController.swift
//  To-do-ee
//
//  Created by Oluwasayofunmi Williams on 27/10/2018.
//  Copyright © 2018 Oluwasayofunmi Williams. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    
    var categoryArray : Results<Category>? //self monitoring onject, hence no need for append method
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

        
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories"
        return cell
    }

    
       // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
            
            
        }
    }
    
    

    
    // MARK: - Data Manipulation Methods
    
    func save(category: Category) {
//save items to database
        
        do{
            try realm.write {
                realm.add(category)
            }
            }catch {
            
            print ("Could not save \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() { //load items from database
        
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
    
    

    // MARK: - Add new Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFeild = UITextField()
        
        let alert = UIAlertController(title: "Add new To-do file", message: "" , preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add file", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textFeild.text!
            
            self.save(category: newCategory) // adds new data to realm database
            
            self.loadCategories()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create new file"
            
            textFeild = alertTextFeild
        }
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    
  
    
    
 
}
