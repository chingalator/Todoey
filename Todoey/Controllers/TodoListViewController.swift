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
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Read Book Love Language"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Do Taxes"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Defeat Zergs"
        itemArray.append(newItem3)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
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
        //print(indexPath.row)
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        // line above replaces all code below
        //if itemArray[indexPath.row].done == false {
         //   itemArray[indexPath.row].done = true
        //}else{
         //   itemArray[indexPath.row].done = false
        //}
        
        tableView.reloadData()
        
        // code below replaced when changed to Data Model format
        //if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
        //    tableView.cellForRow(at: indexPath)?.accessoryType = .none      }
        //else {
         //   tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark        //}
        
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
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
       
        alert.addTextField { (alertTextField) in
          alertTextField.placeholder = "Create Item Here"
          textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}
