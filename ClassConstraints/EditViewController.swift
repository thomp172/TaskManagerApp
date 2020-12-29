//
//  ViewController.swift
//  ClassConstraints
//
//  Created by cpsc on 10/7/20.
//

import UIKit

class EditViewController: UIViewController {
    

    /*switches*/
    @IBOutlet weak var sortSwitch: UISwitch!
    @IBOutlet weak var alertSwitch: UISwitch!

    /*view*/
    @IBOutlet var background: UIView!
   
    /*user default*/
    var defaults: UserDefaults!
    
    /*
     Re sort collection
     */
    @IBAction func sortCollection(_ sender: Any) {
        sort()
        
    }
    /*
     change alert colors for colorblind people
     */
    @IBAction func toggleAlert(_ sender: Any) {
        let alertBool = alertSwitch.isOn
        StorageHandler.setSetting(value: alertBool, type: "alert")
    }
    
    
    func sort() {
        var col = 0
        let sortBool = sortSwitch.isOn
        if sortBool {
          col = 1
        }
        StorageHandler.sort(col:col)
        StorageHandler.setSetting(value: sortBool, type: "sort")
    }
    
    /*
     Load in page
     Adjust background to pre-defined colors
     Add borders to button
     Set up keyboard input
     Set up tap recognition
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let sortBool = StorageHandler.getSetting(type: "sort")
        sortSwitch.isOn = sortBool
        
        let alertBool = StorageHandler.getSetting(type: "alert")
        alertSwitch.isOn = alertBool
        
        //recognize tap
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(EditViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    /*
     Complete edit
     */
    @objc func didTapView() {
        self.view.endEditing(true)
    }

}

