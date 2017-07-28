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
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Variables
    let colors = ["Light Green", "Dark Green", "Yellow", "Orange", "Pink", "Red"]
    var selectedCategoryColor = "Light Green"
    
    // MARK: - IBActions
    @IBAction func didTapSaveButton(_ sender: Any) {
        let colors = ["Light Green": 0xC6DA02, "Dark Green": 0x79A700, "Orange": 0xF68B2C, "Yellow": 0xE2B400, "Red": 0xF5522D, "Pink": 0xFF6E83]
        //TODO: Vlidation
        colors.forEach { (key, value) in
            if key == selectedCategoryColor {
                let selectedColorInt = value
                
                CoreDataTask.saveTask(title: titleTextField.text!, categoryName: categoryNameTextField.text!, categoryColor: Int64(selectedColorInt), date: datePicker.date.description, isCompleted: false)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    func setupUI() {
        categoryColorPickerView.delegate = self
        categoryColorPickerView.dataSource = self
        
        titleTextField.delegate = self
        categoryNameTextField.delegate = self
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

extension AddNewTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

