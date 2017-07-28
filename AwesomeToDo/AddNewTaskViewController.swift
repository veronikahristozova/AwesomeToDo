//
//  AddNewTaskViewController.swift
//  AwesomeToDo
//
//  Created by Veronika Hristozova on 7/28/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import UIKit

class AddNewTaskViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryNameTextField: UITextField!
    @IBOutlet weak var categoryColorPickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Variables
    let colors = ["Light Green", "Dark Green", "Yellow", "Orange", "Pink", "Red"]
    var selectedCategoryColor = "Light Green"
    
    // MARK: - IBActions
    @IBAction func didTapSaveButton(_ sender: Any) {
        let colors = ["Light Green": 0xC6DA02, "Dark Green": 0x79A700, "Orange": 0xF68B2C, "Yellow": 0xE2B400, "Red": 0xF5522D, "Pink": 0xFF6E83]
        
        if let selectedColorInt = (colors.filter { pair in pair.key == selectedCategoryColor }.first?.value) {
            if let title = titleTextField.text, let categoryName = categoryNameTextField.text, titleTextField.text != "", categoryNameTextField.text != "" {
                CoreDataTask.saveTask(title: title, categoryName: categoryName, categoryColor: Int64(selectedColorInt), isCompleted: false)
                
                navigationController?.popViewController(animated: true)
            } else {
                let alertController = UIAlertController(title: "Missing title or category name", message: nil, preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(cancelAction)
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    func setupUI() {
        categoryColorPickerView.delegate   = self
        categoryColorPickerView.dataSource = self
        
        titleTextField.delegate        = self
        categoryNameTextField.delegate = self
        
        saveButton.layer.borderWidth  = 1
        saveButton.layer.borderColor  = UIColor.clear.cgColor
        saveButton.layer.cornerRadius = 4
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

//MARK: - UIPickerView DelegateDataSource
extension AddNewTaskViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       selectedCategoryColor = colors[row]
    }
}

// MARK: - UITextFieldDelegate
extension AddNewTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

