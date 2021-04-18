//
//  SearchViewController.swift
//  Test-Demo
//
//  Created by wanderer on 02/04/21.
//  Copyright © 2021 wanderer. All rights reserved.
//

import UIKit
import FloatingPanel

class SearchViewController: UIViewController, FloatingPanelControllerDelegate {
    let fpc = FloatingPanelController()
    
    lazy var searchVC =
        storyboard?.instantiateViewController(withIdentifier: "fpc_contenvc") as! ContentViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        
        fpc.delegate = self
        
        /*guard let contentVC = storyboard?.instantiateViewController(withIdentifier: "fpc_contenvc") as? ContentViewController else {
            return
        }*/
        fpc.set(contentViewController: searchVC)
        fpc.track(scrollView: searchVC.myTablevIew)
        fpc.addPanel(toParent: self)
        searchVC.searchBar.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func activate(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchVC.showHeader(animated: true)
        searchVC.myTablevIew.alpha = 1.0
    }
    func deactivate(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton  = false
        searchVC.hideHeader(animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        deactivate(searchBar: searchBar)
        UIView.animate(withDuration: 0.25) {
            self.fpc.move(to: .half, animated: false)
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        activate(searchBar: searchBar)
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.fpc.move(to: .full, animated: false)
        }
    }
}

