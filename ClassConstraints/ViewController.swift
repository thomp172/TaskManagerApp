//
//  ViewController.swift
//  ClassConstraints
//
//  Created by cpsc on 10/7/20.
//

import UIKit

class ViewController: UIViewController {
    
    /*title screen label*/
    @IBOutlet weak var label: UILabel!
    
    /*note input fields*/
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var dateInput: UIDatePicker!
    @IBOutlet weak var noteInput: UITextView!
    
    /*buttons*/
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    /*title image*/
    @IBOutlet weak var imageView: UIImageView!
    
    /*scroll view*/
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackview: UIStackView!
    
    /*view*/
    @IBOutlet var background: UIView!
   
    /*user default*/
    var defaults: UserDefaults!
    
    var taskArray: [[String]] = StorageHandler.getStorage()
    var index = -1
    
    /*
     User saves task as default
     */
    @IBAction func saveTask(_ sender: Any) {
        setDefaults()
        sort()
        index = StorageHandler.storageCount() - 1
        label.text = "Edit Notes!"
        deleteButton.isHidden = false
    }
    /*Discard edit*/
    @IBAction func discardTask(_ sender: Any) {
        clearView()
    }
    /*Delete entry*/
    @IBAction func deleteTask(_ sender: Any) {
        StorageHandler.remove(index: index)
        clearView()
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
   
    func clearView() {
        titleInput.text = ""
        noteInput.text = ""
        index = -1
        deleteButton.isHidden = true
        dateInput.setDate(NSDate(timeIntervalSinceNow: 60) as Date, animated: false)
        label.text = "Take Notes!"
    }
    /*
     saves current task in a 2D array
     */
    func setDefaults() {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "MM/dd/yy, hh:mm a"
        
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
  
    /*
     sort stored tasks
     select default of sort by: title
     */
    func sort() {

        var col = 0
        let sortBool = StorageHandler.getSetting(type: "sort")
        print(sortBool)
        if sortBool == true {
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
        //sort values at start of program
        sort()
        //hide delete button
        deleteButton.isHidden = true
        //load UIImageView
        
        //keyboard control
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //recognize tap
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(ViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
        scrollView.addSubview(stackview)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackview.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackview.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackview.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackview.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor).isActive = true
        
        scrollView.heightAnchor.constraint(equalTo: background.heightAnchor).isActive = true
        
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        
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

