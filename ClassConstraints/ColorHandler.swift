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
    static let lateGray = UIColor.lightGray
    static let upcomingGray = UIColor.systemGray5
    
    
    static let defaultColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
    
    static func colorCell(cell: UICollectionViewCell, date: Date, color: Bool) {
        let color = assignColors(date: date, color: color)
        cell.backgroundColor = color
    }
    
    static func assignColors(date: Date, color: Bool) -> UIColor {
        let timestamp = NSDate(timeIntervalSinceNow: 60) as Date
        var lateShade = lateColor
        var upcomingShade = upcomingColor
        if color == false {
            lateShade = lateGray
            upcomingShade = upcomingGray
        }
        var color = checkIfDue(date: date, timestamp: timestamp, choice: lateShade)
        if color == defaultColor {
            let tomorrow = timestamp.addingTimeInterval(86400.0)
            color = checkIfDue(date: date, timestamp: tomorrow, choice: upcomingShade)
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
    
    static func setNotesColor(background: UIView, date: Date, alert: Bool) {
        let color = assignColors(date: date, color: alert)
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
