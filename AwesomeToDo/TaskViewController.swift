//
//  TaskViewController.swift
//  AwesomeToDo
//
//  Created by Veronika Hristozova on 7/28/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    
    // MARK: - Variables
    lazy var previewActions: [UIPreviewActionItem] = {
        
        let deleteAction = UIPreviewAction(title: "Delete", style: .destructive) { action, viewController in
            //Todo: delete from core data
        }
        
        let completeAction = UIPreviewAction(title: "Complete", style: .default) { (action, viewController) in
            // mark as completed
        }
        
        return [completeAction, deleteAction]
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Peek and Pop preview actions
    override var previewActionItems: [UIPreviewActionItem] {
        return previewActions
    }
}
