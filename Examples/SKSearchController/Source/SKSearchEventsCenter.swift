//
//  SKSearchEventsDispatcher.swift
//  SKSearchController
//
//  Created by 王俊硕 on 2018/8/13.
//  Copyright © 2018年 王俊硕. All rights reserved.
//

import UIKit

class SKSearchEventsCenter: NSObject {
    
    // MARK: SearchBar Events
    typealias EmptySearchBarHandler = (UISearchBar)->()
    typealias BoolSearchBarHandler = (UISearchBar)->(Bool)
    
    internal var searchButtonClickHandler: EmptySearchBarHandler?
    internal var searchBarShouldBeginEditingHandler: BoolSearchBarHandler?
    internal var searchBarDidBeginEditingHandler: EmptySearchBarHandler?
    internal var searchBarShouldEndEditingHandler: BoolSearchBarHandler?
    internal var searchBarCancelButtonClickHandler: EmptySearchBarHandler?
    internal var searchTextDidChange: ((UISearchBar, String)->())?
    internal var searchTextShouldChangeInRange: ((UISearchBar, NSRange, String)->(Bool))?

    internal var showDebugInfo = false
}

extension SKSearchEventsCenter: UISearchBarDelegate {
    internal func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let handler = searchBarDidBeginEditingHandler {
            handler(searchBar)
        } else {
            showDebugInfo ~= { print("[SKSearchBarController]: SearchBar ShouldBeginEditing not Handled") }
        }
    }
    internal func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if let handler = searchBarShouldBeginEditingHandler {
            return handler(searchBar)
        } else {
            showDebugInfo ~= { print("[SKSearchBarController]: SearchBar ShouldBeginEditing not Handled") }
            return true
        }
    }
    internal func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if let handler = searchBarShouldEndEditingHandler {
            return handler(searchBar)
        } else {
            showDebugInfo ~= { print("[SKSearchBarController]: SearchBar ShouldEndEditing not Handled") }
            return true
        }
    }
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let handler = searchButtonClickHandler {
            handler(searchBar)
        } else {
            showDebugInfo ~= { print("[SKSearchBarController]: SearchBar ButtonClickEvent not handled") }
        }
    }
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let handler = searchBarCancelButtonClickHandler {
            handler(searchBar)
        } else {
            showDebugInfo ~= { print("[SKSearchBarController]: SearchBar CancelButtonClickEvent not Handled") }
        }
    }
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let handler = searchTextDidChange {
            handler(searchBar, searchText)
        } else {
            showDebugInfo ~= { print("[SKSearchBarController]: SearchBar TextDidChange event not Handled") }
        }
    }
    internal func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let handler = searchTextShouldChangeInRange {
            return handler(searchBar, range, text)
        } else {
            showDebugInfo ~= { print("[SKSearchBarController]: SearchBar CancelButtonClickEvent not Handled") }
            return true
        }
    }
}
