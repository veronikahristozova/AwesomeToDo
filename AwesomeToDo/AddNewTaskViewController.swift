//
//  AddNewTaskViewController.swift
//  AwesomeToDo
//
//  Created by Veronika Hristozova on 7/28/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import UIKit

class AddNewTaskViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryNameTextField: UITextField!
    @IBOutlet weak var categoryColorPickerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let colors = ["Light Green", "Dark Green", "Yellow", "Orange", "Pink", "Red"]
    
    func setupUI() {
        categoryColorPickerView.delegate = self
        categoryColorPickerView.dataSource = self
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
       //
    }
}
