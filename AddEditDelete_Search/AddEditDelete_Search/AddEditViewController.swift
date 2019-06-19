//
//  AddEditViewController.swift
//  AddEditDelete_Search
//
//  Created by Kamui on 6/18/19.
//  Copyright © 2019 Kamui. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var custom : Custom?
    var onComple : (( _ custom: Custom) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photoImageView.image = custom?.photo
        nameTextField.text = custom?.name
        jobTextField.text = custom?.job
        nameTextField.delegate = self
        jobTextField.delegate = self
        saveButton.isEnabled = false
    }

    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let photo = photoImageView.image
        let name = nameTextField.text
        let job = jobTextField.text
        custom = Custom(name: name!, job: job!, photo: photo ?? UIImage(named: "0")!)
        onComple?(custom!)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func tapGusture(_ sender: UITapGestureRecognizer) {
        let imagePickerControl = UIImagePickerController()
        imagePickerControl.sourceType = .photoLibrary
        imagePickerControl.delegate = self
        present(imagePickerControl, animated: true, completion: nil)
    }
}

extension AddEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        jobTextField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (nameTextField.text) == nil || jobTextField.text == nil {
            let alert = UIAlertController(title: "Thong Bao", message: "Thong tin khong duoc nil", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            saveButton.isEnabled = false
        }else {
            saveButton.isEnabled = true
        }
    }
}
extension AddEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let choseImage = info[.originalImage] as? UIImage {
            photoImageView.image = choseImage
        }
        dismiss(animated: true, completion: nil)
    }
}
