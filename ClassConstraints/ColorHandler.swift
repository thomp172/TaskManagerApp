//
//  CellHandler.swift
//  ClassConstraints
//
//  Created by cpsc on 12/15/20.
//

import Foundation
import UIKit

struct ColorHandler {

    static let lateColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
    static let upcomingColor = UIColor(red: 255, green: 218, blue: 0, alpha: 0.5)
    
    static let defaultColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
    
    static func colorCell(cell: UICollectionViewCell, date: Date) {
        let timestamp = NSDate(timeIntervalSinceNow: 60) as Date
        let color = assignColors(date: date)
        cell.backgroundColor = color
    }
    
    static func assignColors(date: Date) -> UIColor {
        let timestamp = NSDate(timeIntervalSinceNow: 60) as Date
        var color = checkIfDue(date: date, timestamp: timestamp, choice: lateColor)
        if color == defaultColor {
            let tomorrow = timestamp.addingTimeInterval(86400.0)
            color = checkIfDue(date: date, timestamp: tomorrow, choice: upcomingColor)
        }
        return color
    }
    
    static func checkIfDue(date: Date, timestamp: Date, choice: UIColor) -> UIColor {
        var color: UIColor = defaultColor
        if date <= timestamp {
            color = choice
        }
        return color
    }
    
    static func setNotesColor(background: UIView, date: Date) {
        let color = assignColors(date: date)
        background.backgroundColor = color
    }
    
    static func setText(text: String, cell: UICollectionViewCell, align: NSTextAlignment) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 50))
           label.text = text
           label.font = UIFont(name: "AvenirNext-Bold", size: 15)
        label.textAlignment = align
           cell.contentView.addSubview(label)
        
    }
    
}
