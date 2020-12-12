//
//  ViewController.swift
//  ClassConstraints
//
//  Created by cpsc on 10/7/20.
//

import UIKit

class ViewController: UIViewController {
    
    /*note input fields*/
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var dateInput: UIDatePicker!
    @IBOutlet weak var noteInput: UITextField!
    
    /*switches*/
    @IBOutlet weak var sortSwitch: UISwitch!
    
    /*buttons*/
    @IBOutlet weak var saveButton: UIButton!

    /*view*/
    @IBOutlet var background: UIView!
   
    /*user default*/
    var defaults: UserDefaults!
    
    
    /*global values*/
    let MAX = 255
    let MIN = 0
    
    var taskArray: [[String]] = StorageHandler.getStorage()
    var index = -1
    
    /*
     User saves task as default
     */
    @IBAction func saveTask(_ sender: Any) {
        setDefaults()
        sort()
    }
    
    /*
     Limit input to max characters
     */
    @IBAction func limitInput(_ sender: Any) {
        var text = titleInput.text ?? ""
        if (text.count > 10) {
            text = String(text.prefix(10))
            titleInput.text = text;
        }
    }
    /*
     Re sort collection
     */
    @IBAction func sortCollection(_ sender: Any) {
        sort()
    }
    
    /*
     saves current task in a 2D array
     */
    func setDefaults() {
        let dateFormatter = DateFormatter()

            dateFormatter.dateStyle = DateFormatter.Style.short
            dateFormatter.timeStyle = DateFormatter.Style.short
        
        let titleValue = titleInput.text!

        let dateValue = dateFormatter.string(from: dateInput.date)
        
        let noteValue = noteInput.text!
        let array = [titleValue,dateValue,noteValue]
        
        if (index != -1) {
            StorageHandler.setAt(value:array, index:index)
        }
        else {
            StorageHandler.set(value: array)
        }
    }
  
    
    func sort() {
        var col = 0
        if sortSwitch.isOn {
          col = 1
        }
        StorageHandler.sort(col:col)
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
        
        //keyboard control
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
     :param: notification
     Show keyboard
     */
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    /*
     :param: notification
     Hide keyboard
     */
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    /*
     Complete edit
     */
    @objc func didTapView() {
        self.view.endEditing(true)
    }


}

