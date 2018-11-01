//
//  CategoryViewController.swift
//  To-do-ee
//
//  Created by Oluwasayofunmi Williams on 27/10/2018.
//  Copyright © 2018 Oluwasayofunmi Williams. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //creates viewcontext object that allows interaction with Database

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

        
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }

    
       // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categoryArray[indexPath.row]
            
            
        }
    }
    
    

    
    // MARK: - Data Manipulation Methods
    
    func saveItems() {
//save items to database
        
        do{
            try context.save()
        }catch {
            
            print ("Could not save \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() { //load items from database
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        // instructions for fetching data from the database
        do{
            categoryArray = try context.fetch(request)
            //save contents of view context into the array
        }catch{
            
            print ("error caught \(error)")
        }
        tableView.reloadData()
    }
    
    
    
    

    // MARK: - Add new Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFeild = UITextField()
        
        let alert = UIAlertController(title: "Add new To-do file", message: "" , preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add file", style: .default) { (action) in
            
            let newItem = Category(context: self.context)
            newItem.name = textFeild.text
            
            self.categoryArray.append(newItem)
            
            self.saveItems()
            
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
