//
//  SKSearchController.swift
//  SKSearchController
//
//  Created by 王俊硕 on 2018/8/11.
//  Copyright © 2018年 王俊硕. All rights reserved.
//

import UIKit

class SKSearchController: UISearchController {
    
    
    // MARK: - Private properties 私有属性
    /// 搜索条文本框
    private var searchField: UITextField? {
        if let searchField = searchBar.value(forKey: "searchField") as? UITextField {
            return searchField
        } else {
            print("[SKSearchController]: Failed to get search field");
            return nil
        }
    }
    /// 文本框背景
    private var searchFieldBackgroudView: UIView? {
        if let field = searchField {
            return field.subviews.first
        } else {
            return nil
        }
    }
    
    private var navigationBarHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return 0
        } else {
            return searchBar.frame.height
        }
    }
    
    
    // MARK: - Text Field 文本输入框
    /// 文本框背景色
    public var textFieldBackgroundColor: UIColor? {
        get {
            if #available(iOS 11.0, *) {
                return searchFieldBackgroudView?.backgroundColor
            } else {
                return searchField?.backgroundColor
            }
        }
        set {
            if #available(iOS 11.0, *) {
                searchFieldBackgroudView?.backgroundColor = newValue
            } else {
                searchField?.backgroundColor = newValue
            }
            textFieldCornerRadius = 10.0
        }
    }
    /// 文本框圆角值 系统自带一层10.0圆角值
    public var textFieldCornerRadius: CGFloat {
        get {
            return searchFieldBackgroudView?.layer.cornerRadius ?? 0
        }
        set {
            searchFieldBackgroudView?.layer.cornerRadius = newValue
            textFieldClipsToBounds = true
        }
    }
    /// 是否显示超出边缘的内容
    public var textFieldClipsToBounds: Bool {
        get {
            return searchField?.clipsToBounds ?? false
        }
        set {
            searchField?.clipsToBounds = newValue
        }
    }
    /// 文字颜色
    public var textFieldTextColor: UIColor? {
        get {
            return searchField?.textColor
        }
        set {
            searchField?.textColor = newValue
        }
    }
    /// 文字字体
    public var textFieldFont: UIFont? {
        get { return searchField?.font }
        set { searchField?.font = newValue }
    }
    /// 光标颜色
    public var cursorColor: UIColor? {
        get { return searchField?.tintColor }
        set { searchField?.tintColor = newValue }
    }
    /// 搜索栏 占位符
    public var placeholder: String? {
        get { return searchField?.placeholder }
        set { searchField?.placeholder = newValue }
    }
    /// 搜索栏 占位符
    public var attributedPlaceholder: NSAttributedString? {
        get {
            return searchField?.attributedPlaceholder
        }
        set {
            searchField?.attributedPlaceholder = newValue
        }
    }
    /// 放大镜颜色
    public var leftIconColor: UIColor? {
        didSet {
            if let color = leftIconColor,
               let iconView = searchField?.leftView as? UIImageView,
               let icon = iconView.image {
                    iconView.image = icon.withRenderingMode(.alwaysTemplate)
                    iconView.tintColor = color
            }

        }
    }
    /// 放大镜
    public var leftIcon: UIImage? {
        didSet {
            searchBar.setImage(leftIcon, for: .search, state: UIControlState.normal)
        }
    }
    /// 清除图标
    public var rightClearIcon: UIImage? {
        didSet {
            searchBar.setImage(rightClearIcon, for: .clear, state: .normal)
        }
    }
    /// 右侧Bookmark图标
    public var rightBookmarkIcon: UIImage? {
        didSet {
            searchBar.setImage(rightBookmarkIcon, for: .bookmark, state: .normal)
        }
    }
    // MARK: - Cancel Button 取消按钮
    public var showCancelButtonWhileEditing: Bool = true {
        willSet {
            searchBar.showsCancelButton = newValue
        }
    }
    /// 设置取消按钮
    public var customizeCancelButton: ((UIButton)->())?
    /// 取消按钮标题，应用于所有点击状态，如果设置了setupCancelButton闭包或者富文本标题则会忽略这个属性
    public var cancelButtonTitle: String?
    /// 取消按钮颜色，应用于所有点击状态，如果设置了setupCancelButton闭包或者富文本标题则会忽略这个属性
    public var cancelButtonColor: UIColor?
    /// iOS11有效。取消按钮富文本标题，应用于所有点击状态，如果设置了setupCancelButton闭包则会忽略这个属性
    public var cancelButtonAttributedTitle: NSAttributedString?

    // MARK: - iOS 10 Setup 设置
    /// 是否隐藏搜索框的上下两条黑线
    public var hideBorderLines: Bool? {
        willSet {
            if newValue == true {
                searchBar.backgroundImage = UIImage()
            }
        }
    }
    /// iOS10 SearchBar Background Color 搜索条背景色, 如果导航栏是有模糊特效的颜色会不一样。 iOS11 的背景色通过导航栏的背景色来设置
    public var barBackgroundColor: UIColor? {
        willSet {
            if #available(iOS 11.0, *) {
            } else {
                searchBar.isTranslucent = false
                searchBar.barTintColor = newValue
            }
            
        }
    }
    /// BackgroundColor of NavigationBar & SearchBar 导航栏和搜索条背景色，关闭导航栏模糊特效
    public var universalBackgoundColor: UIColor? {
        willSet {
            if let bar = navigationController?.navigationBar {
                bar.barTintColor = newValue
                if #available(iOS 11.0, *) {
                } else {
                    barBackgroundColor = newValue
                    hideNavitionBarBottomLine = true
                    bar.isTranslucent = false
                }
            }
            
        }
    }
    private var hideNavitionBarBottomLine: Bool? {
        willSet {
            if newValue == true, let bar = navigationController?.navigationBar {
                
                findNavigationBarBottomLine(from: bar)?.isHidden = true
            }
        }
        
        
    }
    private func findNavigationBarBottomLine(from view: UIView) -> UIImageView? {
        if (view is UIImageView) && view.frame.size.height <= 1.0 {
            return (view as? UIImageView) ?? UIImageView()
        }
        var imageView: UIImageView?
        view.subviews.forEach() {
            if let picView = findNavigationBarBottomLine(from: $0) {
                imageView = picView;
                return
            }
        }
        return imageView
    }
    
    // MARK: - SearchBar Delegate Methods 代理事件闭包
    private var searchBarEventsCenter = SKSearchEventsCenter()
    
    typealias EmptySearchBarHandler = (UISearchBar)->()
    typealias BoolSearchBarHandler = (UISearchBar)->(Bool)
    
    public var searchButtonClickHandler: EmptySearchBarHandler? {
        willSet {
            searchBarEventsCenter.searchButtonClickHandler = newValue
        }
    }
    public var searchBarShouldBeginEditingHandler: BoolSearchBarHandler? {
        willSet {
            searchBarEventsCenter.searchBarShouldBeginEditingHandler = newValue
        }
    }
    public var searchBarDidBeginEditingHandler: EmptySearchBarHandler?
    public var searchBarShouldEndEditingHandler: BoolSearchBarHandler?
    public var searchBarCancelButtonClickHandler: EmptySearchBarHandler?
    public var searchTextDidChange: ((UISearchBar, String)->())?
    public var searchTextShouldChangeInRange: ((UISearchBar, NSRange, String)->(Bool))?

    public var searchBarBookmarkButtonTapped: EmptySearchBarHandler?

    
    
    // MARK: - Private Methods私有方法
    private func allControlState(execute: (UIControlState)->()) {
        [UIControlState.normal, UIControlState.selected, UIControlState.highlighted].forEach() {
            execute($0)
        }
    }
    /// Cancel Button 取消按钮
    private func updateCancelButtonSetting() {
        let tmp = searchBarShouldBeginEditingHandler
        searchBarEventsCenter.searchBarShouldBeginEditingHandler = { searchBar in
            self.setupCancelButton(searchBar: searchBar)
            if let handler = tmp { return handler(searchBar) }
            else { return true }
        }
    }
    /*
     Set up the cancel button
     配置取消按钮
     */
    private func setupCancelButton(searchBar: UISearchBar) {
        if showCancelButtonWhileEditing {
            searchBar.setShowsCancelButton(true, animated: true)
            for view in searchBar.subviews[0].subviews {
                if view is UIButton {
                    let button = view as! UIButton
                    if let handler = customizeCancelButton {
                        handler(button)
                    } else {
                        if let attributedTitle = cancelButtonAttributedTitle {
                            allControlState() {
                                button.setAttributedTitle(attributedTitle, for: $0)
                            }
                        } else {
                            if let title = cancelButtonTitle { allControlState() {
                                button.setTitle(title, for: $0)
                                } }
                            if let color = cancelButtonColor { allControlState() {
                                button.setTitleColor(color, for: $0)
                                } }
                        }
                    }
                    break
                }
            }
        } else {
            searchBar.setShowsCancelButton(false, animated: false)
        }
    }
    
    private func setIcon(image: UIImage?, color: UIColor?, for states: [UIControlState], position: UISearchBarIcon) {
        states.forEach() {
            var icon: UIImage? = image
            if let c = color, let img = image { icon = img.reRender(with: c) }
            searchBar.setImage(icon, for: position, state: $0)
        }
    }
    
    // MARK: - Icons 左右图标设置

    /**
     - Parameters:
       - image: The left icon
       - color: Image will be redrawed if the color is not nil
       - states: An array of UIControlStates that the image will be applied to
     */
    public func setLeftIcon(image: UIImage?, color: UIColor?, for states: [UIControlState]) {
        setIcon(image: image, color: color, for: states, position: .search)
    }
    /**
     - Parameters:
     - image: The bookmark icon
     - color: Image will be redrawed if the color is not nil
     - states: An array of UIControlStates that the image will be applied to
     */
    public func setRightBookmarkIcon(image: UIImage?, color: UIColor?, for states: [UIControlState]) {
        searchBar.showsBookmarkButton = true
        setIcon(image: image, color: color, for: states, position: .bookmark)
    }
    /**
     - Parameters:
     - image: The clear icon
     - color: Image will be redrawed if the color is not nil
     - states: An array of UIControlStates that the image will be applied to
     */
    public func setRightClearIcon(image: UIImage?, color: UIColor?, for states: [UIControlState]) {
        setIcon(image: image, color: color, for: states, position: .clear)
    }
    
    // MARK: - Initalizers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: nil)
        
        updateCancelButtonSetting()
        searchBar.delegate = searchBarEventsCenter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
extension UIImage {
    func reRender(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        if let context = UIGraphicsGetCurrentContext(), let cg = cgImage {
            context.translateBy(x: 0, y: size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.setBlendMode(.normal)
            color.setFill()
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            context.clip(to: rect, mask: cg) // 乘以alpha
            context.fill(rect)
            let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage }
        else {
            print("Failed to get current context or cgImage not exist")
            return nil
        }
    }
}

extension UIColor {
    convenience init(hex: Int) {
        let r = (hex & 0xff0000) >> 16
        let g = (hex & 0x00ff00) >> 8
        let b = hex & 0x0000ff
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
    }
}

func ~= (lhs: Bool, rhs: ()->()) {
    if lhs { rhs() }
}




