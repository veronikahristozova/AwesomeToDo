//
//  MainViewController.swift
//  AwesomeToDo
//
//  Created by Veronika Hristozova on 7/28/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tasksCollectionView: UICollectionView!
    
    // MARK: - Variables
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10.0)
    
    ///Support for devices with no force touch
    lazy var longPress: UILongPressGestureRecognizer = {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        return longPressGesture
    }()
    
    func forceTouchAvailability() {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSingleTask" {
            let singleTaskViewController = segue.destination as! TaskViewController
            if let cell = sender as? TaskCollectionViewCell {
                if let position = tasksCollectionView.indexPath(for: cell)?.row {
                    singleTaskViewController.position = position
                }
            }
        }
    }
    
    // MARK: - Lifecycle Control
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(longPress)
        registerForPreviewing(with: self, sourceView: tasksCollectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        forceTouchAvailability()
        tasksCollectionView.reloadData()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        forceTouchAvailability()
    }
    
    func createDetailViewControllerIndexPath(indexPath: IndexPath) -> TaskViewController {
        let taskViewController = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        taskViewController.position = indexPath.row        
        return taskViewController
    }
}

// MARK: - UICollection View DataSourceDelegate
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CoreDataTask.loadTasks().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TaskCollectionViewCell
        cell.task = CoreDataTask.loadTasks()[indexPath.row]
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

// MARK: - UIViewControllerPreviewingDelegate methods
extension MainViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tasksCollectionView.indexPathForItem(at: location) else {
            return nil
        }
        
        let detailViewController = createDetailViewControllerIndexPath(indexPath: indexPath)
        
        return detailViewController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}
