//
//  TaskViewController.swift
//  AwesomeToDo
//
//  Created by Veronika Hristozova on 7/28/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import UIKit

protocol SingleTaskDelegate {
    func didUpdateTask()
}

class TaskViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    // MARK: - Variables
    var position: Int?
    var delegate: SingleTaskDelegate?
    
    // MARK: - Methods
    func previewActions() -> [UIPreviewActionItem]{
        let deleteAction = UIPreviewAction(title: "Delete", style: .destructive) { action, viewController in
            if let position = self.position, let title = CoreDataTask.loadTask(position: position).title {
                CoreDataTask.deleteTask(title: title, completion: {
                    self.delegate?.didUpdateTask()
                })
            }
        }
        
        let completeAction = UIPreviewAction(title: "Complete", style: .default) { (action, viewController) in
            if let position = self.position, let title = CoreDataTask.loadTask(position: position).title {
                CoreDataTask.markAsCompleted(title: title, completion: { 
                    self.delegate?.didUpdateTask()
                })
            }
        }
         return [completeAction, deleteAction]
    }
    
    func setupUI() {
        if let position = position {
            let task = CoreDataTask.loadTask(position: position)
            titleLabel.text = "To Do: \(task.title ?? "")"
            categoryNameLabel.text = "\(task.categoryName ?? "") category"
            completedLabel.text = task.isCompleted ? "Completed" : "Pending"
            view.backgroundColor = UIColor(netHex: Int(task.categoryColor))
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Peek and Pop preview actions
    override var previewActionItems: [UIPreviewActionItem] {
        return previewActions()
    }
}
