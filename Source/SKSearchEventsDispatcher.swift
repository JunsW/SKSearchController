//
//  SKSearchEventsDispatcher.swift
//  SKSearchController
//
//  Created by 王俊硕 on 2018/8/13.
//  Copyright © 2018年 王俊硕. All rights reserved.
//

import UIKit

class SKSearchEventsDispatcher: NSObject {
    
    // MARK: SearchBar Events
    typealias EmptySearchBarHandler = (UISearchBar)->()
    typealias BoolSearchBarHandler = (UISearchBar)->(Bool)
    
    public var searchButtonClickHandler: EmptySearchBarHandler?
    public var searchBarShouldBeginEditingHandler: BoolSearchBarHandler?
    public var searchBarDidBeginEditingHandler: EmptySearchBarHandler?
    public var searchBarShouldEndEditingHandler: BoolSearchBarHandler?
    public var searchBarCancelButtonClickHandler: EmptySearchBarHandler?
    public var searchTextDidChange: ((UISearchBar, String)->())?
    public var searchTextShouldChangeInRange: ((UISearchBar, NSRange, String)->(Bool))?

    public var showDebugInfo = true
}

extension SKSearchEventsDispatcher: UISearchBarDelegate {
    internal func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let handler = searchBarDidBeginEditingHandler {
            handler(searchBar)
        } else {
            showDebugInfo ~= { print("[FSSearchBarController]: SearchBar ShouldBeginEditing not Handled") }
        }
    }
    internal func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if let handler = searchBarShouldBeginEditingHandler {
            return handler(searchBar)
        } else {
            showDebugInfo ~= { print("[FSSearchBarController]: SearchBar ShouldBeginEditing not Handled") }
            return true
        }
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if let handler = searchBarShouldEndEditingHandler {
            return handler(searchBar)
        } else {
            showDebugInfo ~= { print("[FSSearchBarController]: SearchBar ShouldEndEditing not Handled") }
            return true
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let handler = searchButtonClickHandler {
            handler(searchBar)
        } else {
            showDebugInfo ~= { print("[FSSearchBarController]: SearchBar ButtonClickEvent not handled") }
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let handler = searchBarCancelButtonClickHandler {
            handler(searchBar)
        } else {
            showDebugInfo ~= { print("[FSSearchBarController]: SearchBar CancelButtonClickEvent not Handled") }
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let handler = searchTextDidChange {
            handler(searchBar, searchText)
        } else {
            showDebugInfo ~= { print("[FSSearchBarController]: SearchBar TextDidChange event not Handled") }
        }
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let handler = searchTextShouldChangeInRange {
            return handler(searchBar, range, text)
        } else {
            showDebugInfo ~= { print("[FSSearchBarController]: SearchBar CancelButtonClickEvent not Handled") }
            return true
        }
    }
}
