//
//  ViewController.swift
//  Notefy
//
//  Created by Chiruvolu, Sricharan on 07/05/17.
//  Copyright © 2017 Chiruvolu, Sricharan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    var data:[String] = []
    var file:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Notefy"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        let docsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        file = docsDir[0].appending("notefy.txt")
        load()
    }
    
    func addNote(){
        if(table.isEditing){
            return
        }
        let name:String = "Row \(data.count + 1)"
        data.insert(name, at: 0)
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        save()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
        save()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(data[indexPath.row])")
    }
    
    func save(){
//        Saving to persistant storage
//        TODO: Save it to cloud
//        UserDefaults.standard.set(data, forKey: "notes")
//        UserDefaults.standard.synchronize()
        
        
        let newData:NSArray = NSArray(array: data)
        newData.write(toFile: file, atomically: true)
    }

    func load(){
//        Saving to persistant storage
//        TODO: Save it to cloud
//        if let loadedData = UserDefaults.standard.value(forKey: "notes") as? [String] {
//            data = loadedData
//            table.reloadData()
//        }
        
        if let loadedData = NSArray(contentsOfFile: file) as? [String] {
            data = loadedData
            table.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

