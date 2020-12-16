//
//  SwatchesViewController.swift
//  ClassConstraints
//
//  Created by Christopher Boyd on 10/26/20.
//

import UIKit

final class SwatchesViewController: UICollectionViewController {
    private let reuseIdentifier = "SwatchCell";
    private let sectionInsets = UIEdgeInsets(
        top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0)
    
    private let itemsPerRow: CGFloat = 1
    private let itemsPerCol: CGFloat = 8
    private var taskArray: [[String]] = StorageHandler.getStorage()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.alwaysBounceVertical = true

        self.loadView()
    }
}

extension SwatchesViewController {
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return StorageHandler.storageCount()
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {

    // Get the newest update
    taskArray = StorageHandler.getStorage()
    let taskValueArray = taskArray[indexPath.item]
   
    let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
    ColorHandler.setText(text: taskValueArray[0],cell: cell, align: .left)
    
    ColorHandler.setText(text:taskValueArray[1], cell:cell, align: .right)
    
    let date = StorageHandler.getDate(str: taskValueArray[1])
    let color = StorageHandler.getSetting(type: "alert")
    ColorHandler.colorCell(cell: cell, date: date, color: color)
    
    
    return cell
  }
    
    
}


extension SwatchesViewController : UICollectionViewDelegateFlowLayout {
    
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    let heightPerItem = availableWidth/itemsPerCol
    
    
    return CGSize(width: widthPerItem, height: heightPerItem)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}

extension SwatchesViewController {
    
  override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    
    let taskValueArray = taskArray[indexPath.item]
    let taskTab = tabBarController!.viewControllers![0] as! ViewController

    taskTab.titleInput.text = "\(taskValueArray[0])"
    let dateText = "\(taskValueArray[1])"
    taskTab.dateInput.date = StorageHandler.getDate(str: dateText)
    taskTab.noteInput.text = "\(taskValueArray[2])"
    taskTab.label.text = "Edit Notes!"
    taskTab.deleteButton.isHidden = false
    
    taskTab.index = indexPath.item
    self.tabBarController!.selectedIndex = 0

    return false
  }
}
