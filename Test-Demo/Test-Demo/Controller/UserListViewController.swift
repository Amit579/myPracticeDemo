//
//  UserListViewController.swift
//  Test-Demo
//
//  Created by wanderer on 2/28/21.
//  Copyright © 2021 wanderer. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {

    @IBOutlet weak var userListTblView: UITableView!
    
    //MARK:- Defining Cell identifiers
    let cellReuseIdentifier = "userCell"
    let cellspacingHeight : CGFloat = 5
    let userDataArray = [String]()
    
    //MARK:- Declare Array for table view row's
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        userListTblView.delegate = self
        userListTblView.dataSource = self
        userListTblView.register(UINib(nibName: "UserListViewTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
    }
}
//MARK:- extension functions
extension UserListViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.animals.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return userDataArray.count
        return 1
        
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellspacingHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let usercell : UserListViewTableViewCell = userListTblView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UserListViewTableViewCell
        usercell.userProfileImageView.image = #imageLiteral(resourceName: "username")
        usercell.nameLabel.text = "Name : Amit Sharma"
        usercell.emailLabel.text = "Email: amit@gmail.com"
        usercell.dobLabel.text = "DOB: 05-07-1990"
        usercell.numberLabel.text = "Contact Number.:9999999999"
        
        // add border and color
        usercell.backgroundColor = UIColor.white
        usercell.layer.borderColor = UIColor.black.cgColor
        usercell.layer.borderWidth = 1
        usercell.layer.cornerRadius = 8
        usercell.clipsToBounds = true
        
        return usercell
    }
    
}
