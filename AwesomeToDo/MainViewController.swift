//
//  MainViewController.swift
//  AwesomeToDo
//
//  Created by Veronika Hristozova on 7/28/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Variables
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10.0)

    var tasks = [Task]()
    
    
    ///Support for devices with no force touch
    lazy var longPress: UILongPressGestureRecognizer = {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        return longPressGesture
    }()
    
    func check3DTouchEnabledFlag() {
        if self.traitCollection.forceTouchCapability == .available {
            self.longPress.isEnabled = false
            //Force touch exists
        } else {
            self.longPress.isEnabled = true
            //Force touch does not exist on this device
        }
    }
    
    func handleLongPress() {
        print("Long press button clicked")
        //TODO:
    }
    
    // MARK: - Lifecycle Control
    override func viewDidLoad() {
        super.viewDidLoad()
        let task1 = Task(title: "Walk the dog", categoryName: "Work", categoryColor: ColorPalette.Pink, date: nil)
        let task2 = Task(title: "Buy flowers", categoryName: "Home", categoryColor: ColorPalette.LightGreen, date: nil)
        
        let task3 = Task(title: "idk i'm tired lets try something", categoryName: "Chritmas", categoryColor: ColorPalette.DarkGreen, date: nil)
        let task4 = Task(title: "idk i'm tired lets try something", categoryName: "Chritmas", categoryColor: ColorPalette.Orange, date: nil)
        let task5 = Task(title: "idk i'm tired lets try something", categoryName: "Chritmas", categoryColor: ColorPalette.Yellow, date: nil)
        let task6 = Task(title: "idk i'm tired lets try something isd kjh jh jkh kh h h ", categoryName: "Chritmas", categoryColor: ColorPalette.Red, date: nil)
        tasks.append(task1)
        tasks.append(task2)
        tasks.append(task3)
        tasks.append(task4)
        tasks.append(task5)
        tasks.append(task6)
        
        self.view.addGestureRecognizer(longPress)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        check3DTouchEnabledFlag()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        check3DTouchEnabledFlag()
    }
}

// MARK: - UICollection View DataSourceDelegate
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todocell", for: indexPath) as! TaskCollectionViewCell
        cell.task = tasks[indexPath.row]
        // Configure the cell
        return cell
    }
}

// MARK: - UICollection View Delegate Flow Layout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
