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
    
    
    func sort() {
        var col = 0
        var sortBool = sortSwitch.isOn
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
        
        var sortBool = StorageHandler.getSetting(type: "sort")
        sortSwitch.isOn = sortBool
        
        //recognize tap
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(ViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    /*
     :param: key
     return value if key is not nil
     */
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    /*
     :param: key
     set key to existing value
     */
    func setKeyInUserDefaults(value: [String]) {
        StorageHandler.set(value: value)
    }
    
    
    /*
     Complete edit
     */
    @objc func didTapView() {
        self.view.endEditing(true)
    }


}

