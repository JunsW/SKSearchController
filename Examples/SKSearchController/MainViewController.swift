//
//  ViewController.swift
//  SKSearchController
//
//  Created by 王俊硕 on 2018/8/11.
//  Copyright © 2018年 王俊硕. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var searchController: SKSearchController!
    @IBOutlet weak var contentView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Demo"
        
        searchController = SKSearchController(searchResultsController: nil)
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false // 这样子可以在进入页面的时候不隐藏
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.hidesNavigationBarDuringPresentation = true // 编辑的时候隐藏导航栏
        } else {
            contentView.tableHeaderView = searchController.searchBar
        };
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do the settings here. Some settings could be unavailable otherwise.
        setupSearchController()
    }
    func setupSearchController() {
        searchController.placeholder = "SKSearchController Demo"
        searchController.customizeCancelButton = { button in
            button.setTitle("Punch", for: UIControlState.normal)
            button.backgroundColor = UIColor(hex: 0xEE7F79)
            button.layer.cornerRadius = 4
        }
        searchController.barBackgroundColor = UIColor(hex: 0xF9F9FA)
        searchController.leftIconColor =  UIColor(hex: 0xEE7F79)
        searchController.rightIconColor =  UIColor(hex: 0xEE7F79)
        searchController.cursorAndCancelButtonColor = UIColor(hex: 0x333333)
        searchController.textFieldTextColor = UIColor(hex: 0xbbbbbb)
//        searchController.hideBorderLines = true
        searchController.textFieldBackgroundColor = UIColor(hex: 0xF9F9FA)
    }

}

