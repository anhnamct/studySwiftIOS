//
//  HungDuLieuViewController.swift
//  UserDefault
//
//  Created by Kamui on 6/18/19.
//  Copyright © 2019 Kamui. All rights reserved.
//

import UIKit

class HungDuLieuViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var number: Int?
    var onCompile : ((_ number: Int) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        numberTextField.text = "\(number ?? 0)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let number = Int(numberTextField.text ?? "0")
        onCompile?(number!)
        navigationController?.popViewController(animated: true)
    }
    
}
