//
//  ViewController.swift
//  Todoey
//
//  Created by Charles Tibbels on 4/7/18.
//  Copyright © 2018 invescity. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print(dataFilePath)
        
        loadItems()
        
        
    }
    //Mark Tableview Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        // Ternary operator above replaces the code below
        //if item.done == true {
        //    cell.accessoryType = .checkmark
        //}else {
        //    cell.accessoryType = .none
        //}
 
        return cell
    }
    
    //Mark - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark - Add new items
    
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what happens when user clicks add item
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
        }
       
        alert.addTextField { (alertTextField) in
          alertTextField.placeholder = "Create Item Here"
          textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    //Mark - Model Manipulation Methods
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write (to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
       
        
       self.tableView.reloadData()
        
        }
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
               print("Error decoding item array, \(error)" )
            }
        }
        
    }
}
    


