//
//  ViewController.swift
//  To-do-ee
//
//  Created by Oluwasayofunmi Williams on 16/10/2018.
//  Copyright © 2018 Oluwasayofunmi Williams. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    
   
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "ANDREWWW"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "You the man Steve"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "I'm your hormone monster"
        itemArray.append(newItem3)
        
        
        
        
        if let items = defaults.array(forKey: "TODOobject") as? [Item]{
            itemArray = items
        }
    }
    
    //MARK - Tableview Datasource methods
    
    
    
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
    
    //MARK - Tableview Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (itemArray[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        
       
    }


    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
    
        var textFeild: UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add new to-do item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //stuff to happen when user clicks add item button
            
            let newItem = Item()
            newItem.title = textFeild.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TODOobject")
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create new Item"
            textFeild = alertTextFeild
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
}

