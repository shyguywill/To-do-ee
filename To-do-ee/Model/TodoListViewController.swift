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
    
    
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        loadItems()
        
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
        
        saveItems()
        
        
       
    }


    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
    
        var textFeild: UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add new to-do item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //stuff to happen when user clicks add item button
            
            let newItem = Item()
            newItem.title = textFeild.text!
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
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            
            try data.write(to: dataFilePath!)
            
        }
            
        catch{
            
            print ("Error encoding item array \(error)")
            
        }
        
        
        tableView.reloadData()
        
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            }catch {
                print ("Couldn't decode data \(error)")
            }
        }
    }
    
    
}

