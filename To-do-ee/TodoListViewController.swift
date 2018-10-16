//
//  ViewController.swift
//  To-do-ee
//
//  Created by Oluwasayofunmi Williams on 16/10/2018.
//  Copyright © 2018 Oluwasayofunmi Williams. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    
    var itemArray = ["ANDREWWW","You the man Steve","I'm your Hormone Monster"]
    let defaults = UserDefaults.standard
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TODOobject") as? [String]{
            
            itemArray = items
        }
    }
    
    //MARK - Tableview Datasource methods
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    //MARK - Tableview Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
       
    }


    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
    
        var textFeild: UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add new to-do item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //stuff to happen when user clicks add item button
            
            self.itemArray.append(textFeild.text!)
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

