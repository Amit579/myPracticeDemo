//
//  ContentViewController.swift
//  Test-Demo
//
//  Created by wanderer on 02/04/21.
//  Copyright © 2021 wanderer. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet var myTablevIew : UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    //    let data = ["Cow","Goat","Lion","Panther"]
    
    var candies: [Candy] = []
    var filteredCandies : [Candy] = []
    var searchTokens: [UISearchToken] = []
    var isSearchBarEmpty : Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
        //&& searchController.searchBar.text!.count >= 3
    }

    
    let searchController = UISearchController(searchResultsController: nil)
    // nil means it'll display results in same vc
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        myTablevIew.delegate = self
        myTablevIew.dataSource = self
        
//        myTablevIew.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTablevIew.tableFooterView = UIView()
        
        
        candies = Candy.candies()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true //removes search bar while navigating
        
    }
    
    func filterContentForSearchText(_ searchText: String,
                                    category: Candy.Category? = nil)  {
      //filter logic of array
      if searchText.count >= 3 {
        //call api and append into candies
        filteredCandies = candies.filter{(candy : Candy) -> Bool in
          return candy.name.lowercased().contains(searchText.lowercased())
        }
      }
      makeTokens()
      myTablevIew.reloadData()
    }
}

/*extension ContentViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
}*/




@available(iOS 13.0, *)
extension ContentViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard isFiltering else {return}
   
    let index =  searchTokens.firstIndex(of: searchTokens[indexPath.row])
    let str = searchTokens[indexPath.row].representedObject as? String
   
    didSelect(tokenString: str, atIndex: index!)
    
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    if isFiltering {
      return filteredCandies.count
    }

    return isFiltering ? searchTokens.count : 0
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let cell = myTablevIew.dequeueReusableCell(withIdentifier: "cell",
                                             for: indexPath) as! TableViewCell
    let candy : Candy
    if isFiltering {
      candy = filteredCandies[indexPath.row]
    }
    else{
      candy = candies[indexPath.row]
    }
    cell.name.text = candy.name
    return cell
  }
//MARK:- Header section
    private func changeHeader(height: CGFloat, aniamted: Bool) {
        guard let headerView = myTablevIew.tableHeaderView, headerView.bounds.height != height else { return }
        if aniamted == false {
            updateHeader(height: height)
            return
        }
        myTablevIew.beginUpdates()
        UIView.animate(withDuration: 0.25) {
            self.updateHeader(height: height)
        }
        myTablevIew.endUpdates()
    }
    private func updateHeader(height: CGFloat) {
        guard let headerView = myTablevIew.tableHeaderView else { return }
        var frame = headerView.frame
        frame.size.height = height
        self.myTablevIew.tableHeaderView?.frame = frame
    }
  
    func showHeader(animated: Bool) {
        changeHeader(height: 116.0, aniamted: animated)
    }

    func hideHeader(animated: Bool) {
        changeHeader(height: 0.0, aniamted: animated)
    }
    
}

@available(iOS 13.0, *)
extension ContentViewController : UISearchResultsUpdating {
  //updates search results
  func updateSearchResults(for searchController: UISearchController) {
    searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
  
  func makeTokens() {
    let candiesList : [Candy]
    if isFiltering {
      candiesList = filteredCandies
    }
    else{
      return
     // candiesList = candies
    }
    searchTokens = candiesList.map{(candy) -> UISearchToken in
      let token = UISearchToken(icon: UIImage(), text: candy.name)
      token.representedObject = candy.name
      return token
    }
  }
  
  func didSelect(tokenString: String?, atIndex: Int) {

    // 1
       let searchTextField = searchController.searchBar.searchTextField
       // 2
   let token = UISearchToken(icon: UIImage(), text: tokenString!)
    searchTextField.insertToken(token, at:0)
    searchTextField.text = ""
       // 3
    filterContentForSearchText(searchController.searchBar.text!)
  }
  
}
