//
//  HungDuLieuViewController.swift
//  StudySegueAddEditDelete
//
//  Created by Kamui on 5/30/19.
//  Copyright © 2019 Kamui. All rights reserved.
//

import UIKit

class HungDuLieuViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var numberTextField: UITextField!
    var number: Int = 0
    var viTri: Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        numberTextField.text = "\(number)"
        numberTextField.delegate = self
        saveButton.isEnabled = false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        numberTextField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if Int(textField.text!) == nil {
            let alert = UIAlertController(title: "Thông báo", message: "Thông tin nhập sai, yêu cầu nhập đúng số", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            saveButton.isEnabled = true
        }
    }
    

}
