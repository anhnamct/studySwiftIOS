//
//  CustomViewController.swift
//  AddEditDelete_Search
//
//  Created by Kamui on 6/18/19.
//  Copyright © 2019 Kamui. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var customs = [Custom]()
    var filterCustom = [Custom]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadSample()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gan = segue.destination as? AddEditViewController {
            if segue.identifier == "add" {
                gan.onComple = {
                    (custom) in
                    self.customs.append(custom)
                    self.filterCustom = self.customs
                    self.tableView.reloadData()
                }
            } else if segue.identifier == "edit" {
                if let idx = tableView.indexPathForSelectedRow?.row {
                    gan.custom = customs[(tableView.indexPathForSelectedRow?.row)!]
                    gan.onComple = {
                        (custom) in
                        self.customs[idx] = custom
                        self.filterCustom = self.customs
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func loadSample() {
        let photo1 = UIImage(named: "0")
        customs.append(Custom(name: "Van Hong Lang", job: "Van Duong Tong", photo: photo1!))
        filterCustom = customs
    }
}
extension CustomViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterCustom.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.imageView?.image = filterCustom[indexPath.row].photo
        cell.imageView?.contentMode = .scaleAspectFill
        cell.textLabel?.text = filterCustom[indexPath.row].name
        cell.detailTextLabel?.text = filterCustom[indexPath.row].job
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            customs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
extension CustomViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filterCustom = customs
            tableView.reloadData()
            return
        }
        filterCustom = customs.filter({
            custom -> Bool in
            custom.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

class Custom {
    var name: String
    var job: String
    var photo: UIImage
    init(name: String, job: String, photo: UIImage) {
        self.name = name
        self.job = job
        self.photo = photo
    }
}

