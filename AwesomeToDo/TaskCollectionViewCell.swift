//
//  TaskCollectionViewCell.swift
//  AwesomeToDo
//
//  Created by Veronika Hristozova on 7/28/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import UIKit

class TaskCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var categoryColorView: UIView!
    @IBOutlet weak var pinImageView: UIImageView!
    
    var task: Task? { didSet { updateUI() } }

    func updateUI() {
        if let task = task {
            taskTitleLabel.text = task.title
            categoryColorView.backgroundColor = task.categoryColor
            pinImageView.tintColor = task.isCompleted ? .green : .red
        }
        
        self.layer.cornerRadius = 4
        self.layer.borderWidth  = 1
        self.layer.borderColor  = UIColor.lightGray.cgColor
        self.backgroundColor    = task?.categoryColor
    }
}
