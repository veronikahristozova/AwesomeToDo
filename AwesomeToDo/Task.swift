//
//  Task.swift
//  AwesomeToDo
//
//  Created by Veronika Hristozova on 7/28/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import UIKit

class Task {
    var title: String
    var categoryName: String
    var categoryColor: UIColor
    var date: String?
    var isCompleted: Bool = false
    
    init(title: String, categoryName: String, categoryColor: UIColor, date: String?) {
        self.title = title
        self.categoryName = categoryName
        self.categoryColor = categoryColor
        self.date = date
    }
}
