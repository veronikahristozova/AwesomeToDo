//
//  TaskViewController.swift
//  AwesomeToDo
//
//  Created by Veronika Hristozova on 7/28/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var position: Int?
    
    // MARK: - Methods
    func previewActions() -> [UIPreviewActionItem]{
        let deleteAction = UIPreviewAction(title: "Delete", style: .destructive) { action, viewController in
            if let position = self.position, let title = CoreDataTask.loadTask(position: position).title {
                CoreDataTask.deleteTask(title: title)
            }
        }
        
        let completeAction = UIPreviewAction(title: "Complete", style: .default) { (action, viewController) in
            if let position = self.position, let title = CoreDataTask.loadTask(position: position).title {
                CoreDataTask.markAsCompleted(title: title)
            }
        }
         return [completeAction, deleteAction]
    }
    
    func setupUI() {
        if let position = position {
            label.text = CoreDataTask.loadTask(position: position).title
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
