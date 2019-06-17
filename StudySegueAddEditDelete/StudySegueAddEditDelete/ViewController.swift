//
//  ViewController.swift
//  StudySegueAddEditDelete
//
//  Created by Kamui on 5/30/19.
//  Copyright © 2019 Kamui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    var numbers = Array(0..<10)
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gan = segue.destination as! HungDuLieuViewController
        if segue.identifier == "add"{
            gan.number = 0
        } else if segue.identifier == "edit" {
            let viTri = tableView.indexPathForSelectedRow?.row
            gan.viTri = viTri
            gan.number = numbers[tableView.indexPathForSelectedRow?.row ?? -1]
        }
    }
    @IBAction func unwindToViewController(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "saveNumber" {
            let sourceViewController = unwindSegue.source as! HungDuLieuViewController
            if let number = Int(sourceViewController.numberTextField.text!) {
                let viTri = sourceViewController.viTri
                if viTri != nil {
                    numbers[viTri!] = number
                    tableView.reloadData()
                } else {
                    numbers.append(number)
                    tableView.reloadData()
                }
            }
        }
    }

}

