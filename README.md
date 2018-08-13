# SKSearchController
![Build Pass](https://img.shields.io/travis/rust-lang/rust.svg)
![Language](https://img.shields.io/badge/swift-4.0-orange.svg)

A Wrap for UISearchController makes all customization super easy.

## Demo
Dwonload and check out the demo project.  
**iOS 11**  
![iOS 11](https://github.com/JunsW/FTSearchController/blob/master/Pics/DemoiOS11_1.png)  
![iOS 11](https://github.com/JunsW/FTSearchController/blob/master/Pics/DemoiOS11_2.png)  
**iOS 11 lower**  
![Compatible](https://github.com/JunsW/FTSearchController/blob/master/Pics/DemoiOS10.png)  
(I know the demo color pattern is kind of urgly, forgive me :D. I will improve it soon)
## Installation
### Manual
Download `.swift` files in _Source_.
## Usage
`class ViewController: FTSearchController`  
Just inherit the `FTSearchController`.  
`FTSearchController` already provide a `UITableView` for you to show reuslt.  
Just implement the all in one protocol `FTSearchControllerDataProvider `

###1. Customize UI
**Setup TextField**  

- `textFieldBackgroundColor`: Backgournd color of `textField` in `searchControler's searchBar`
- `textFieldCornerRadius`: corner radius of the `textField`
- `textFieldTextColor`: text color of `textField`
- `textFieldFont`: text font of `textField`
- `cursorColor`: Set cursor color by changing the tint color of the searchBar
- `attributedPlaceholder`: set up the `attributedPlaceholder` of the `textField`
- `leftIconColor`: the color of the magnifying lends in the `textField`
- `rightIconColor`: the clear button in the `textField`  
  
**Setup CancelButton**  

- `customizeCancelButton`: (UIButton)->(): a clourse help you setup the cancel button
- `cencelButtonAttributedTitle`: This attribute only valid when customizeCancelButton block is nil
- `cancelButtonColor`: This attribute only valid when `customizeCancelButton` block and `cencelButtonAttributedTitle ` is nil 
- `cancelButtonTitle`: This attribute only valid when `customizeCancelButton` block and `cencelButtonAttributedTitle` is nil

**Setup Bar**    

- `hideBorderLines`: wether hide the upper and lower border line of the `searchBar`
- `barBackgroundColor`: set the search bar background, only working on iOS 11 lower
- `universalBackgoundColor`: set the search bar and the `navigationBar` background. This attribute will also set `searchBar.isTranslucent` to `false` on iOS 11 lower
- `hideNavitionBarBottomLine`: wether hide the bottom line of the `navigationBar`

### 2. UISearchBar Delegate
The delegate methods of `UISearchBar` has been convert to closures like below  


    typealias EmptySearchBarHandler = (UISearchBar)->()
    typealias BoolSearchBarHandler = (UISearchBar)->(Bool)
    
    public var searchButtonClickHandler: EmptySearchBarHandler?
    public var searchBarShouldBeginEditingHandler: BoolSearchBarHandler?
    public var searchBarShouldEndEditingHandler: BoolSearchBarHandler?
    public var searchBarCancelButtonClickHandler: EmptySearchBarHandler?
    
    public var searchTextDidChange: ((UISearchBar, String)->())?
    public var searchTextShouldChangeInRange: ((UISearchBar, NSRange, String)->(Bool))?
    
### 3. FTSearchControllerDataProvider
This protocol simply inherits `UITableViewDelegate`, `UITableViewDataSource`, `UISearchResultUpdating`.

