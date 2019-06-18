//
//  AddEditViewController.swift
//  PassingDataClosured+Search
//
//  Created by Kamui on 6/18/19.
//  Copyright © 2019 Kamui. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var ageLable: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    var student: Student?
    var onCompile : ((_ student: Student) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = student?.name
        ageTextField.text = "\(student?.age ?? 0)"
        saveButton.isEnabled = false
        updateTextFieldDelegete()
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let name = nameTextField.text
        let age = Int(ageTextField.text!)
        let student = Student(name: name!, age: age!)
        onCompile?(student)
        navigationController?.popViewController(animated: true)
    }
}

extension AddEditViewController: UITextFieldDelegate {
    func updateTextFieldDelegete() {
        self.nameTextField.delegate = self
        self.ageTextField.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if Int(ageTextField.text!) == nil {
           let alert = UIAlertController(title: "Thông báo", message: "Thông tin tuổi nhập không đúng", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
}
