//
//  ChatViewController.swift
//  Test-Demo
//
//  Created by wanderer on 31/03/21.
//  Copyright © 2021 wanderer. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var chatTableView: UITableView!
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    let cellIdentifier = "chatCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

