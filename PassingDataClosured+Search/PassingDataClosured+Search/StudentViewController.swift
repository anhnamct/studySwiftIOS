//
//  StudentViewController.swift
//  PassingDataClosured+Search
//
//  Created by Kamui on 6/18/19.
//  Copyright © 2019 Kamui. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var students = [Student]()
    var filterStudents = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateTableViewDelegate()
        updateSearchDelegate()
        loadSample()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gan = segue.destination as? AddEditViewController else {return}
        if segue.identifier == "add" {
            gan.onCompile = {
                (student) in
                self.students.append(student)
                self.filterStudents = self.students
                self.tableView.reloadData()
            }
        } else if segue.identifier == "edit" {
            let idx = (tableView.indexPathForSelectedRow?.row)!
            gan.student = students[(tableView.indexPathForSelectedRow?.row)!]
            gan.onCompile = {
                (student) in
                self.students[idx] = student
                self.filterStudents = self.students
                self.tableView.reloadData()
            }
        }
    }
    
    func loadSample() {
        students.append(Student(name: "Hoang Nam", age: 25))
        students.append(Student(name: "Van Linh", age: 26))
        students.append(Student(name: "Truong Thuy", age: 27))
        students.append(Student(name: "Tuan Anh", age: 28))
        students.append(Student(name: "Truong Vu", age: 29))
        filterStudents = students
    }
}
extension StudentViewController: UITableViewDataSource, UITableViewDelegate {
    func updateTableViewDelegate() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterStudents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filterStudents[indexPath.row].name
        cell.detailTextLabel?.text = "\(filterStudents[indexPath.row].age)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            students.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
extension StudentViewController : UISearchBarDelegate {
    func updateSearchDelegate() {
        self.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filterStudents = students
            tableView.reloadData()
            return
        }
        filterStudents = students.filter({
            student -> Bool in
            student.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

