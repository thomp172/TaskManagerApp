//
//  CellHandler.swift
//  ClassConstraints
//
//  Created by cpsc on 12/15/20.
//

import Foundation
import UIKit

struct CellHandler {
    
    static var cellArray: [UICollectionViewCell] = []
    
    static let lateColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
    static let upcomingColor = UIColor(red: 255, green: 218, blue: 0, alpha: 0.5)
    
    static func colorCell(cell: UICollectionViewCell, date: Date) {
        let timestamp = NSDate(timeIntervalSinceNow: 60) as Date
        if date <= timestamp {
            cell.backgroundColor = lateColor
            
        }
        else {
            let tomorrow = timestamp.addingTimeInterval(86400.0)
            if (date <= tomorrow) {
                
                cell.backgroundColor = upcomingColor
            }
            
        }
    }
    
    static func manageCells() {
        
    }
    
    
    
}
