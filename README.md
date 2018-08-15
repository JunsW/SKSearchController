# SKSearchController
![Logo](https://raw.githubusercontent.com/JunsW/SKSearchController/master/Assets/SKSearchControllerLogo.jpg)  

![Build Pass](https://img.shields.io/travis/rust-lang/rust.svg)
![Language](https://img.shields.io/badge/swift-4.0-orange.svg)

A Wrap for UISearchController makes all customization super easy.

## Demo
Dwonload and check out the demo project. 

![Demo](https://raw.githubusercontent.com/JunsW/SKSearchController/master/Assets/Demo.gif)  
## Requirements
- **iOS** 8.0+
- **Swift** 4.0+

## Installation
### Cocoapods
`Pod SKSearchController`
### Manual
Download two `.swift` files in _Source_.

## Usage
#### 1. Initialization.  
Toltally same initilizers as `UISearchController`  
`var searchController = SKSearchController(searchResultsController: nil)`  
#### 2. Setup  

__All the setups must be done in the `ViewDidAppear:`. Some seting would be unavailable otherwise.__


```

    func setupSearchController() {
        searchController.placeholder = "SKSearchController Demo"
        searchController.customizeCancelButton = { button in
            button.setAttributedTitle(NSAttributedString(string: "Punch", attributes: [.foregroundColor : UIColor.white, .font: UIFont.systemFont(ofSize: 15)]), for: .normal)
            button.backgroundColor = UIColor(hex: 0xEE7F79)
            button.layer.cornerRadius = 4
        }

        searchController.barBackgroundColor = UIColor(hex: 0xF9F9FA)
        
        searchController.leftIcon = UIImage(named: "football")
        searchController.leftIconColor =  UIColor(hex: 0xEE7F79)
        searchController.setRightBookmarkIcon(image: UIImage(named: "speaker"), color: UIColor(hex: 0xEE7F79), for: [UIControlState.normal])
        searchController.setRightClearIcon(image: UIImage(named: "x"), color: UIColor(hex: 0xEE7F79), for: [UIControlState.normal])
        
        searchController.cursorColor = UIColor(hex: 0x333333)
        searchController.textFieldTextColor = UIColor(hex: 0xbbbbbb)
        searchController.hideBorderLines = true
        searchController.textFieldBackgroundColor = UIColor(hex: 0xF9F9FA)
        
        searchController.searchTextDidChange = { searchBar, text in
            print("Keyword: \(text)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do the settings here. Some settings could be unavailable otherwise.
        setupSearchController()
    }
```
   
## Documents
### 1. Properties
**TextField**  
- `textFieldBackgroundColor`: Backgournd color of `textField` in `searchControler's searchBar`
- `textFieldCornerRadius`: corner radius of the `textField`
- `textFieldTextColor`: text color of `textField`
- `textFieldFont`: text font of `textField`
- `cursorColor`: Set cursor color by changing the tint color of the searchField
- `placeholder`: set up the `placeholder` of the `searchBar`
- `attributedPlaceholder`: set up the `attributedPlaceholder` of the `textField`

**CancelButton**  
- `showCancelButtonWhileEditing`: determing whether shows the cancel button or not.
- `customizeCancelButton`: (UIButton)->(): a clourse help you setup the cancel button
- `cencelButtonAttributedTitle`: This attribute only valid when `customizeCancelButton` block is `nil`
- `cancelButtonColor`: This attribute only valid when `customizeCancelButton` block and `cencelButtonAttributedTitle ` are both `nil` 
- `cancelButtonTitle`: This attribute only valid when `customizeCancelButton` block and `cencelButtonAttributedTitle` are both `nil`

**Icons**
- `leftIcon`: Set a image to the left search icon.
- `rightClearIcon`: Set a image to the clear icon showed while you are typing
- `rightBookmarkIcon`: Set a image to the bookmark icon showed on the right of the search field.


**Bar**    

- `hideBorderLines`: whether hide the upper and lower border line of the `searchBar`
- `barBackgroundColor`: set the search bar background, only working on iOS 11 and lower
- `universalBackgoundColor`: set the search bar and the `navigationBar` background. This attribute will also set `searchBar.isTranslucent` to `false` on iOS 11 and lower
- `hideNavitionBarBottomLine`: whether hide the bottom line of the `navigationBar`
### 2. Methods


```func setLeftIcon(image: UIImage?, color: UIColor?, for states: [UIControlState])```
Set a image to the left search icon. The icon will be redered in the color if it's not `nil`.

```func setRightBookmarkIcon(image: UIImage?, color: UIColor?, for states: [UIControlState])```
Set a image to the right bookmark icon. The icon will be redered in the color if it's not `nil`.

```func setRightClearIcon(image: UIImage?, color: UIColor?, for states: [UIControlState])```
Set a image to the right clear icon. The icon will be redered in the color if it's not `nil`.


### 3. UISearchBar Delegate
The delegate methods of `UISearchBar` has been convert to closures like below  


    typealias EmptySearchBarHandler = (UISearchBar)->()
    typealias BoolSearchBarHandler = (UISearchBar)->(Bool)
    
    public var searchButtonClickHandler: EmptySearchBarHandler?
    public var searchBarShouldBeginEditingHandler: BoolSearchBarHandler?
    public var searchBarShouldEndEditingHandler: BoolSearchBarHandler?
    public var searchBarCancelButtonClickHandler: EmptySearchBarHandler?
    
    public var searchTextDidChange: ((UISearchBar, String)->())?
    public var searchTextShouldChangeInRange: ((UISearchBar, NSRange, String)->(Bool))?


So set it up like this

    searchController.searchTextDidChange = 
    { searchBar, text in
            print("Content: \(text)")
    }

Simple and efficient

## Todo
- [ ] Objective-C version
