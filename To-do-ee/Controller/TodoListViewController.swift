//
//  ViewController.swift
//  To-do-ee
//
//  Created by Oluwasayofunmi Williams on 16/10/2018.
//  Copyright © 2018 Oluwasayofunmi Williams. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
   
    var todoItem : Results<Item>?
    let realm = try! Realm()
    
    
   
    
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
        return todoItem?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItem?[indexPath.row]{
            
            cell.textLabel?.text = todoItem?[indexPath.row].title
            cell.accessoryType = item.done ? .checkmark:.none
            
        }else {
            
            cell.textLabel?.text = "No items avalialable"
            
        }
        
        
        
        
        return cell
        
        
    }
    
    //MARK: - Tableview Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
       
        do{
            try realm.write {
                
                if let item = self.todoItem?[indexPath.row] {
                    
                    item.done = !item.done
                }
            }
        }catch{
                
                print ("An error occured \(error)")
            }
        
        tableView.reloadData()
        
        
    }


    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
    
        var textFeild = UITextField()
        
        let alert = UIAlertController(title: "Add new to-do item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //stuff to happen when user clicks add item button
            
            if let newCategory = self.selectedCategory{
                
                do{
                    try self.realm.write {
                        
                        let newItem = Item()
                        newItem.title = textFeild.text!
                        newItem.dateCreated = Date()
                        newCategory.items.append(newItem)
                    }
                }catch {
                    
                    print ("Could not save \(error)")
                }
                
                
                
            }
            
            
            self.tableView.reloadData()
            
            }
        
        alert.addAction(action)
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create new Item"
            textFeild = alertTextFeild
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
//    func saveItems() {
//
//        do{
//           try context.save()
//
//            tableView.reloadData()
//        }catch{
//
//            print ("Error saving context \(error)")
//        }
//
//
//    }
    
    
    

    func loadItems() {
        
        todoItem = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate{
//
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        }else {
//            request.predicate = categoryPredicate
//        }
//
//        do {
//            itemArray = try context.fetch(request)
//
//        }catch {
//            print ("There was an error of type \(error)")
//        }

        tableView.reloadData()

    }
    
    
    
}

//MARK: - Search Bar Methods
extension ToDoListViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItem = todoItem?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()

//        let searchRequest : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//
//        searchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: searchRequest, predicate: predicate)



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

