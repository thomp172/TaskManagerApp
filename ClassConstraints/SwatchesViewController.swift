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
    private let itemsPerRow: CGFloat = 3
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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

    // Get the corresponding color
    let cellColorsArray = StorageHandler.getStorage()
    let cellColorArray = cellColorsArray[indexPath.item]
    /*let cellColor = UIColor(red: CGFloat(cellColorArray[0])/255, green: CGFloat(cellColorArray[1])/255, blue: CGFloat(cellColorArray[2])/255, alpha: 1.0)
    */
    
    let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
    //cell.backgroundColor = cellColor
    
    let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 50))
       title.text = cellColorArray[0]
       title.font = UIFont(name: "AvenirNext-Bold", size: 15)
       title.textAlignment = .center
       cell.contentView.addSubview(title)
    
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
    
    return CGSize(width: widthPerItem, height: widthPerItem)
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
    let cellColorsArray = StorageHandler.getStorage()
    let cellColorArray = cellColorsArray[indexPath.item]
    let colorTab = tabBarController!.viewControllers![0] as! ViewController

    colorTab.titleInput.text = "\(cellColorArray[0])"
    colorTab.dateInput.text = "\(cellColorArray[1])"
    colorTab.noteInput.text = "\(cellColorArray[2])"
    
    
    self.tabBarController!.selectedIndex = 0

    return false
  }
}
