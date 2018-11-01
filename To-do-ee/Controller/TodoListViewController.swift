//
//  ViewController.swift
//  To-do-ee
//
//  Created by Oluwasayofunmi Williams on 16/10/2018.
//  Copyright © 2018 Oluwasayofunmi Williams. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
   
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory: Category? {
        didSet{
            
            loadItems()
        }
    }
    
    
     //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    //MARK: - Tableview Datasource methods
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        let item = itemArray[indexPath.row]
        
        cell.accessoryType = item.done ? .checkmark:.none
        
        
        return cell
        
        
    }
    
    //MARK: - Tableview Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (itemArray[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        
       
    }


    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
    
        var textFeild = UITextField()
        
        let alert = UIAlertController(title: "Add new to-do item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //stuff to happen when user clicks add item button
            
            
            
            let newItem = Item(context: self.context)
            newItem.title = textFeild.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            
            self.saveItems()
            }
        
        alert.addAction(action)
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create new Item"
            textFeild = alertTextFeild
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func saveItems() {
        
        do{
           try context.save()
            
            tableView.reloadData()
        }catch{
            
            print ("Error saving context \(error)")
        }
        
        
    }
    
    
    
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate{
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        }else {
            request.predicate = categoryPredicate
        }
        
        do {
            itemArray = try context.fetch(request)
            
        }catch {
            print ("There was an error of type \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
    
}

//MARK: - Search Bar Methods
extension ToDoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchRequest : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        
        searchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: searchRequest, predicate: predicate)
        
     
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            
            loadItems()
            
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
            
        }
    }
    
    
}

