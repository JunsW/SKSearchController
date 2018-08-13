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
        searchController = SKSearchController(searchResultsController: nil)

        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            contentView.tableHeaderView = searchController.searchBar
        };
        

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupSearchController()
    }
    func setupSearchController() {
//        searchController.cancelButtonTitle = "好的"
        searchController.placeholder = "开始搜索"
        searchController.customizeCancelButton = { button in
            button.setTitle("试一试", for: UIControlState.normal)
            button.backgroundColor = .gray
            button.layer.cornerRadius = 4
        }
        searchController.barBackgroundColor = .white
        searchController.leftIconColor = .orange
        searchController.rightIconColor = .red
        searchController.cursorAndCancelButtonColor = UIColor.cyan
        searchController.textFieldTextColor = .white
        searchController.hideBorderLines = true
        searchController.textFieldBackgroundColor = .yellow
    }

}

