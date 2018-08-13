//
//  SKSearchController.swift
//  SKSearchController
//
//  Created by 王俊硕 on 2018/8/11.
//  Copyright © 2018年 王俊硕. All rights reserved.
//

import UIKit

class SKSearchController: UISearchController {
    
    
    // MARK: - 私有属性
    /// 搜索条文本框
    private var searchField: UITextField? {
        if let searchField = searchBar.value(forKey: "searchField") as? UITextField {
            return searchField
        } else {
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
    /// 文本框清楚按钮
    private var clearButtonImage: UIImage {
        let image = UIImage(named: "x")!
        if let color = rightIconColor, let icon = image.reRender(with: color) {
            return icon
        } else {
            return image
        }
        
    }
    private var navigationBarHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return 0
        } else {
            return searchBar.frame.height
        }
    }
    
    
    // MARK: - 文本输入框
    /// 文本框背景色
    open var textFieldBackgroundColor: UIColor? {
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
    open var textFieldCornerRadius: CGFloat {
        get {
            return searchFieldBackgroudView?.layer.cornerRadius ?? 0
        }
        set {
            searchFieldBackgroudView?.layer.cornerRadius = newValue
            textFieldClipsToBounds = true
        }
    }
    /// 是否显示超出边缘的内容
    open var textFieldClipsToBounds: Bool {
        get {
            return searchField?.clipsToBounds ?? false
        }
        set {
            searchField?.clipsToBounds = newValue
        }
    }
    /// 文字颜色
    open var textFieldTextColor: UIColor? {
        get {
            return searchField?.textColor
        }
        set {
            searchField?.textColor = newValue
        }
    }
    /// 文字字体
    open var textFieldFont: UIFont? {
        get { return searchField?.font }
        set { searchField?.font = newValue }
    }
    /// 光标和取消按钮颜色 它们自动继承上级视图的tintColor属性
    open var cursorAndCancelButtonColor: UIColor? {
        get { return searchBar.tintColor }
        set { searchBar.tintColor = newValue }
    }
    /// 搜索栏 占位符
    open var placeholder: String? {
        get { return searchBar.placeholder }
        set { searchBar.placeholder = newValue }
    }
    /// 搜索栏 占位符
    open var attributedPlaceholder: NSAttributedString? {
        get {
            return searchField?.attributedPlaceholder
        }
        set {
            searchField?.attributedPlaceholder = newValue
        }
    }
    /// 放大镜颜色
    open var leftIconColor: UIColor? {
        didSet {
            if let color = leftIconColor, let field = searchField {
                let iconView = field.leftView as! UIImageView
                if let pic = iconView.image {
                    iconView.image = pic.withRenderingMode(.alwaysTemplate)
                    iconView.tintColor = color
                } else {
                    print("----------------")
                }
            }

        }
    }
    /// 右边图标颜色
    open var rightIconColor: UIColor?
    
    // MARK: - 取消按钮
    public var showCancelButtonWhileEditing: Bool = true {
        willSet {
            searchBar.showsCancelButton = newValue
        }
    }
    /// 设置取消按钮
    open var customizeCancelButton: ((UIButton)->())?
    /// 取消按钮标题，应用于所有点击状态，如果设置了setupCancelButton闭包或者富文本标题则会忽略这个属性
    open var cancelButtonTitle: String?
    /// 取消按钮颜色，应用于所有点击状态，如果设置了setupCancelButton闭包或者富文本标题则会忽略这个属性
    open var cancelButtonColor: UIColor?
    /// iOS11有效。取消按钮富文本标题，应用于所有点击状态，如果设置了setupCancelButton闭包则会忽略这个属性
    open var cencelButtonAttributedTitle: NSAttributedString?

    // MARK: - iOS 10 设置
    /// 是否隐藏搜索框的上下两条黑线
    open var hideBorderLines: Bool? {
        willSet {
            if newValue == true {
                searchBar.backgroundImage = UIImage()
            }
        }
    }
    /// iOS10 搜索条背景色, 如果导航栏是有模糊特效的颜色会不一样。 iOS11 的背景色通过导航栏的背景色来设置
    open var barBackgroundColor: UIColor? {
        willSet {
            if #available(iOS 11.0, *) {
            } else {
                searchBar.isTranslucent = false
                searchBar.barTintColor = newValue
            }
            
        }
    }
    /// 导航栏和搜索条背景色，关闭导航栏模糊特效
    open var universalBackgoundColor: UIColor? {
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
    
    // MARK: - SearchBar代理事件闭包
    public var searchBarEventsCenter = SKSearchEventsDispatcher()
    
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

    
    
    // MARK: - 私有方法
    private func allControlState(execute: (UIControlState)->()) {
        [UIControlState.normal, UIControlState.selected, UIControlState.highlighted].forEach() {
            execute($0)
        }
    }
    // MARK: 取消按钮
    private func updateCancelButtonSetting() {
        let tmp = searchBarEventsCenter.searchBarDidBeginEditingHandler
        searchBarEventsCenter.searchBarDidBeginEditingHandler = { searchBar in
            self.setupCancelButton(searchBar: searchBar)
            if let handler = tmp { handler(searchBar) }
//            else { return true }
        }
    }
    /*
     配置取消按钮
     取消按钮需要在代理searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool中调用
     
     */
    private func setupCancelButton(searchBar: UISearchBar) {
        if showCancelButtonWhileEditing {
            searchBar.setShowsCancelButton(true, animated: true)
            print("[FSSearchBarController]: 查找替换取消按钮")
            for view in searchBar.subviews[0].subviews {
                if view is UIButton {
                    let button = view as! UIButton
                    if let handler = customizeCancelButton {
                        handler(button)
                    } else {
                        if let attributedTitle = cencelButtonAttributedTitle {
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
    // MARK: - 左侧放大镜
    private func updateLeftIconSetting() {
        if let color = leftIconColor, let field = searchField {
            let iconView = field.leftView as! UIImageView
            if let pic = iconView.image {
                iconView.image = pic.withRenderingMode(.alwaysTemplate)
                iconView.tintColor = color
            } else {
                print("----------------")
            }
        }
        
    }
    // MARK: - 右侧小图标
    private func updateRightIconSetting() {
        let tmp = searchBarEventsCenter.searchBarDidBeginEditingHandler
        searchBarEventsCenter.searchBarDidBeginEditingHandler = { searchBar in
            self.setupRightIcon(searchBar: searchBar)
            if let handler = tmp { handler(searchBar) }
        }
    }
    private func setupRightIcon(searchBar: UISearchBar) {
        allControlState() {
            searchBar.setImage(clearButtonImage, for: UISearchBarIcon.clear, state: $0)
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: nil)
        
        updateCancelButtonSetting()
        updateRightIconSetting()
        searchBar.delegate = searchBarEventsCenter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        if #available(iOS 11.0, *) {
            setupSearchBarForIOS11()
        } else {
            setupSearchBarForCompatible()
        }
    }
    
    /// 在ViewDidAppear()中对iOS11导航栏内嵌入搜索框配置样式 子类需要重写来自定义样式
    func setupSearchBarForIOS11() {
        
    }
    /// 在ViewDidAppear()中对iOS11以下搜索框配置样式 子类需要重写来自定义样式
    func setupSearchBarForCompatible() {
        
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
extension CGRect {
    func scale(x: CGFloat, y: CGFloat) -> CGRect {
        return CGRect(x: 0, y: 0, width: width*x, height: height*y)
    }
}

func ~= (lhs: Bool, rhs: ()->()) {
    if lhs { rhs() }
}

