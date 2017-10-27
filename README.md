# UILogger

[![CI Status](http://img.shields.io/travis/truemetal/ios-ui-logger.svg?style=flat)](https://travis-ci.org/truemetal/ios-ui-logger)
[![Version](https://img.shields.io/cocoapods/v/UILogger.svg?style=flat)](http://cocoapods.org/pods/UILogger)
[![License](https://img.shields.io/cocoapods/l/UILogger.svg?style=flat)](http://cocoapods.org/pods/UILogger)
[![Platform](https://img.shields.io/cocoapods/p/UILogger.svg?style=flat)](http://cocoapods.org/pods/UILogger)

Did you ever have a need to add logging of user actions to see how to reproduce that crash? This pod does just that.

```swift
UILogHelper.printToConsole = false

NotificationCenter.default.addObserver(forName: UILogItem.uiLogNotification, object: nil, queue: nil) { n in
    // handle log event, e.g. add it to your crash reporter's
    guard let log = n.object as? UILogItem else { return }
    if log.type == .viewControllerDidAppear { }
    if log.type == .controlAction { }
}
```

At this point `n.object` is an instance of `UILogItem` which has these properties:
```obj-c
@property (nonatomic) UILogItemType type;
@property (nonatomic, strong, nonnull) NSDate *timestamp;
@property (nonatomic, strong, nonnull) NSObject *object;
@property (nonatomic, strong, nullable) NSString *title;
@property (nonatomic, strong, nullable) NSIndexPath *indexPath;
```

This is quite a bare-bone implementation, please feel free to open the issue if you'd like a feature added. A pull-request would be even better.

Under the hood it's `obj-c` code that swizzles `UIApplication`, `UIViewController`, `UITableView` and `UICollectionView`.
Please let me know if you have a better idea for implementing this then swizzling.

## Example

To run the example project, clone the repo, and run  `pod install`  from the Example directory first.

## Installation

UILogger is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'UILogger'
```

## ToDo

- clean up console logging logic
- make `UILogTitle` protocol and extensions for `UIViewController`, `UIButton`, `UICollectionViewCell` to provide it's meaningful title

## Author

Dan Pashchenko
<br>https://ios-engineer.com

## License

UILogger is available under the MIT license. See the LICENSE file for more info.
