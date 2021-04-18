//
//  ViewController.swift
//  Test-Demo
//
//  Created by wanderer on 2/28/21.
//  Copyright © 2021 wanderer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Defining IBOutlet's
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var DOBtextField: UITextField!
    @IBOutlet weak var NumberTextField: UITextField!
    @IBOutlet weak var userSaveButton: UIButton!
    @IBOutlet weak var userPageButton: UIButton!
    
    //MARK:- Defining Datepicker
    let datePicker = UIDatePicker()
    let calendar = Calendar.current
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createDatePicker()
    }
    
//MARK:- Form Create for DOB
    func createDatePicker(){
        //Button Corner Radius
        userSaveButton.layer.cornerRadius = 20
        userSaveButton.layer.borderWidth = 1
        
        userPageButton.layer.cornerRadius = 20
        userPageButton.layer.borderWidth = 1
        
        //Formate Date
        datePicker.datePickerMode = .date
        
        //Block Future Year for date of Birth
        let currentYear = calendar.component(.year, from: Date())
        guard let maximumDate = calendar.date(from: DateComponents(year: currentYear + 1))?.addingTimeInterval(-1) else {
            fatalError("Couldn't get next year")
        }
        datePicker.maximumDate = maximumDate
        print(datePicker.maximumDate ?? "")
        
        //ToolBar
          let toolbar = UIToolbar();
          toolbar.sizeToFit()
          let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
         let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
         DOBtextField.inputAccessoryView = toolbar
         DOBtextField.inputView = datePicker
        
    }
    
    //MARK:- Done Date Picker
    @objc func donedatePicker(){
      let formatter = DateFormatter()
      formatter.dateFormat = "dd/MM/yyyy"
      DOBtextField.text = formatter.string(from: datePicker.date)
      self.view.endEditing(true)
    }
    
    //MARK:- Cancel Date Picker
    @objc func cancelDatePicker(){
       self.view.endEditing(true)
     }
    
    
//MARK:- Form Save Data in Core Data
    @IBAction func saveButton(_ sender: UIButton) {
        print("Save User Data!")
        
        saveActionCall()
        
    }
    
    func saveActionCall(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UserListVC") as! UserListViewController
//        self.present(nextViewController, animated:true, completion:nil)
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func pageNavigateButton(_ sender: UIButton) {
        actionPageCall()
    }
    
    func actionPageCall(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PageNationVC") as! PaginationViewController
        /*let nextViewController = storyBoard.instantiateViewController(withIdentifier: "searchVC") as! SearchViewController*/
        
//        searchVC
//        self.present(nextViewController, animated:true, completion:nil)
        print("My Print test")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

