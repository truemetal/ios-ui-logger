# UILogger

Did you ever have a need to add logging of user actions to see how to reproduce that crash? This pod does just that.

```swift
UILogHelper.printToConsole = false

NotificationCenter.default.addObserver(forName: UILogItem.uiLogNotification, object: nil, queue: nil) { n in
    // handle log event, e.g. like this. Event details are in n.object
    guard let log = n.object as? UILogItem else { return }
    if log.type == .viewControllerDidAppear { }
    if log.type == .controlAction { }
}
```

It's quite a bare-bone implementation now, please feel free to open the issue if you'd like a feature added. A pull-request would be even better.

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

## Author

Dan Pashchenko, https://ios-engineer.com

## License

UILogger is available under the MIT license. See the LICENSE file for more info.
