# UILogger

[![CI Status](http://img.shields.io/travis/truemetal/ios-ui-logger.svg?style=flat)](https://travis-ci.org/truemetal/ios-ui-logger)
[![Version](https://img.shields.io/cocoapods/v/UILogger.svg?style=flat)](http://cocoapods.org/pods/UILogger)
[![License](https://img.shields.io/cocoapods/l/UILogger.svg?style=flat)](http://cocoapods.org/pods/UILogger)
[![Platform](https://img.shields.io/cocoapods/p/UILogger.svg?style=flat)](http://cocoapods.org/pods/UILogger)

Did you ever have a need to add logging of user actions to see how to reproduce that crash? This pod does just that.

```swift
UILogger.printToConsole = false

NotificationCenter.default.addObserver(forName: UILogger.uiLogNotification, object: nil, queue: nil) { (n) in
    guard let logItem = n.object as? UILogItem else { return }
    // do something here with logItem
    print("received log item: \(UILoggerLaunchTimeHolder.appUptime()) \(logItem.descriptionDict)")
}
```

At this point `n.object` is an instance of one of the subclasses of `UILogItem`. Each of the subclasses store action details in properties (please feel free to take a look at those), also each subclass implements this property, which contains all details as strings:
```swift
public lazy var descriptionDict: [String : String]
```

#### Action types

There're these log action types: `viewControllerDidAppear`, `controlAction`, `tableCellTap` and `collectionCellTap`

Under the hood there's `swift` code for the logic and `obj-c` code that swizzles `UIApplication`, `UIViewController`, `UITableView` and `UICollectionView`.
Please let me know if you have a better idea for implementing this then swizzling.

#### Cell title customization

There's this protocol if you'd like to return title from custom table or collection view cell:

```swift
public protocol UILogTitleProvider {
    var uiLogTitle: String? { get }
}
```

## Example

To run the example project, clone the repo and open the workspace from the `Example` dir.

## Installation

UILogger is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'UILogger'
```

## Author

Dan Pashchenko
<br>https://ios-engineer.com

## License

UILogger is available under the MIT license. See the LICENSE file for more info.
