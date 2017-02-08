## AHAlertView

代替系统自带的UIAlertView，在保持UIAlertView使用代理的习惯，还支持Block形式。支持多按钮选项。

## Usage

```swift
let button1 = UIButton(frame: CGRectMake(50, 50, 200, 50))
button1.backgroundColor = UIColor.redColor()
button1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
button1.setTitle("测试两个选项", forState: UIControlState.Normal)
button1.addTarget(self, action: #selector(self.testAlert0), forControlEvents: UIControlEvents.TouchUpInside)
self.view.addSubview(button1)

let button = UIButton(frame: CGRectMake(50, 130, 200, 50))
button.backgroundColor = UIColor.redColor()
button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
button.setTitle("测试多个选项", forState: UIControlState.Normal)
button.addTarget(self, action: #selector(self.testAlert1), forControlEvents: UIControlEvents.TouchUpInside)
self.view.addSubview(button)

func testAlert0() {
let alertView = AHAlertView(title: "测试两个选项", message: "message", block: { (alertView, buttonIndex) in

print("点击\(buttonIndex)")

}, cancelButtonTitle: "cancel", otherButtonTitles: "0")
alertView.show()
}

func testAlert1() {

let alertView = AHAlertView(title: "测试多个选项", message: "message", block: { (alertView, buttonIndex) in

print("点击\(buttonIndex)")

}, cancelButtonTitle: "cancel", otherButtonTitles: "0", "1", "2", "3")
alertView.show()
}
```

## CocoaPods

CocoaPods is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate AHCategories into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'AHAlertView'
```

Then, run the following command:

```bash
$ pod install
```
