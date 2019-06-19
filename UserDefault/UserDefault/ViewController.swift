//
//  ViewController.swift
//  UserDefault
//
//  Created by Kamui on 6/18/19.
//  Copyright © 2019 Kamui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    static let nameKey = "number"
    static let userSectionKey = "com.save.usersection"
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var numbers = Array(0...10)
   
    //var numbers = UserDefaults.standard.array(forKey: "number")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
        if let array = UserDefaults.standard.value(forKey: "array") as? [Int] {
            self.numbers = array
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(numbers[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            numbers.remove(at: indexPath.row)
            UserDefaults.standard.set(self.numbers, forKey: "array")
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gan  = segue.destination as? HungDuLieuViewController {
            if segue.identifier == "add" {
                gan.onCompile = {
                    (number) in
                    self.numbers.append(number) 
                    UserDefaults.standard.set(self.numbers, forKey: "array")
                    self.tableView.reloadData()
                }
            } else if segue.identifier == "edit" {
                let idx = tableView.indexPathForSelectedRow?.row
                gan.onCompile = {
                    (number) in
                    self.numbers[idx!] = number
                    UserDefaults.standard.set(self.numbers, forKey: "array")
                    self.tableView.reloadData()
                }
            }
        }
    }

}

