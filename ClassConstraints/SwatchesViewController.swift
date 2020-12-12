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
    
    let title = setText(text: cellColorArray[0],cell: cell, align: .left)
    let date = setText(text:cellColorArray[1], cell:cell, align: .right)
    
    return cell
  }
}

func setText(text: String, cell: UICollectionViewCell, align: NSTextAlignment) -> UILabel {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 50))
       label.text = text
       label.font = UIFont(name: "AvenirNext-Bold", size: 15)
    label.textAlignment = align
       cell.contentView.addSubview(label)
       return label
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
    func getDate(date_str: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy, hh:mm a"
        let isoDate = "\(date_str)"
        let date = dateFormatter.date(from:isoDate)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let foundDate = calendar.date(from:components)
        return foundDate!
    }
  override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    let cellColorsArray = StorageHandler.getStorage()
    let cellColorArray = cellColorsArray[indexPath.item]
    let colorTab = tabBarController!.viewControllers![0] as! ViewController

    colorTab.titleInput.text = "\(cellColorArray[0])"
    
    colorTab.dateInput.date = getDate(date_str: cellColorArray[1])
    colorTab.noteInput.text = "\(cellColorArray[2])"
    
    
    self.tabBarController!.selectedIndex = 0

    return false
  }
}
