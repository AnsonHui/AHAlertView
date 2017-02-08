//
//  AHAlertView.swift
//  Meepoo
//
//  Created by 黄辉 on 6/13/16.
//  Copyright © 2016 com.meizu.flyme. All rights reserved.
//

import UIKit
import AHAutoLayout_Swift

public protocol AHAlertViewDelegate: NSObjectProtocol {

    func ahAlertView(_ alertView: AHAlertView, clickedButtonAtIndex buttonIndex: Int)
}

public typealias AHAlertViewBlock = ((_ alertView: AHAlertView, _ buttonIndex: Int) -> Void)

open class AHAlertView: UIView {

    fileprivate let kIndexCancelButton: Int = 10

    fileprivate var panelView: UIImageView!

    fileprivate var delegate: AnyObject?
    fileprivate var block: AHAlertViewBlock?

    fileprivate var titleLabel: UILabel!
    fileprivate var messageLabel: UILabel!

    fileprivate var buttons = [UIButton]()

    fileprivate var keyWindow: UIWindow?

    // 支持Extension显示
    open var viewForExtension: UIView?

    // 正常的字体颜色
    open static var normalTextColor = UIColor.black
    // 高亮字体颜色
    open static var highlightTextColor = UIColor.blue
    // 分界线颜色
    open static var seperatorLineColor = UIColor.lightGray

    public init(title: String?, message: String?, delegate: AnyObject?, cancelButtonTitle: String?, otherButtonTitles firstButtonTitle: String? = nil, _ moreButtonTitles: String...) {
        super.init(frame: UIScreen.main.bounds)

        self.delegate = delegate
        self.initial(title, message: message, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: firstButtonTitle, moreButtonTitles: moreButtonTitles)
    }

    public init(title: String?, message: String?, block: AHAlertViewBlock?, cancelButtonTitle: String?, otherButtonTitles firstButtonTitle: String? = nil, _ moreButtonTitles: String...) {
        super.init(frame: UIScreen.main.bounds)

        self.block = block
        self.initial(title, message: message, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: firstButtonTitle, moreButtonTitles: moreButtonTitles)
    }

    fileprivate func initial(_ title: String?, message: String?, cancelButtonTitle: String?, otherButtonTitles firstButtonTitle: String? = nil, moreButtonTitles: [String]?) {

        self.isUserInteractionEnabled = true

        // 背景框
        let podBundle = Bundle(for: type(of: self))
        var backgroundImage: UIImage!
        if let image = UIImage(named: "alert_bg", in: podBundle, compatibleWith: nil) {
            backgroundImage = image
        } else {
            backgroundImage = UIImage()
        }
        let stretchImage = backgroundImage.stretchableImage(withLeftCapWidth: Int(backgroundImage.size.width / 2), topCapHeight: Int(backgroundImage.size.height / 2))
        self.panelView = UIImageView(image: stretchImage)
        self.panelView.contentMode = UIViewContentMode.scaleToFill
        self.panelView.isUserInteractionEnabled = true
        self.panelView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.panelView)

        self => self.panelView.centerX == self.centerX
        self => self.panelView.centerY == self.centerY
        self => self.panelView.width == backgroundImage.size.width

        // 标题
        self.titleLabel = UILabel()
        self.titleLabel.textColor = AHAlertView.normalTextColor
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        self.titleLabel.numberOfLines = 2
        self.titleLabel.textAlignment = NSTextAlignment.center
        self.titleLabel.text = title
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.panelView.addSubview(self.titleLabel!)

        self.panelView => self.titleLabel.left == self.panelView.left + 32
        self.panelView => self.titleLabel.right == self.panelView.right - 32
        self.panelView => self.titleLabel.top == self.panelView.top + 40

        // 副标题
        self.messageLabel = UILabel()
        self.messageLabel.textColor = AHAlertView.normalTextColor
        self.messageLabel.font = UIFont.systemFont(ofSize: 14.0)
        self.messageLabel.textAlignment = NSTextAlignment.center
        self.messageLabel.numberOfLines = 0
        self.messageLabel.text = message
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.panelView.addSubview(self.messageLabel)

        self.panelView => self.messageLabel.left == self.titleLabel.left
        self.panelView => self.messageLabel.right == self.titleLabel.right
        self.panelView => self.messageLabel.top == self.titleLabel.bottom + 20

        // 按钮标题
        var buttonTitles = [String]()
        if let buttonTitle = firstButtonTitle {
            buttonTitles.append(buttonTitle)
        }
        moreButtonTitles?.forEach { (buttonTitle) in
            buttonTitles.append(buttonTitle)
        }
        if let buttonTitle = cancelButtonTitle {
            buttonTitles.append(buttonTitle)
        }

        // 按钮
        for i in 0 ..< buttonTitles.count {
            let button = self.makeButton()
            button.tag = i
            button.setTitle(buttonTitles[i], for: UIControlState.normal)
            if i == 0 {
                button.setTitleColor(AHAlertView.highlightTextColor, for: UIControlState.normal)
            } else {
                button.setTitleColor(AHAlertView.normalTextColor, for: UIControlState.normal)
            }
            self.panelView.addSubview(button)

            if buttonTitles.count < 3 { // 横排
                // 顶部布局
                self.panelView => button.top == self.messageLabel.bottom + 10

                if i == 0 {
                    // 左侧布局
                    self.panelView => button.left == self.panelView.left + 20
                    // 右侧布局
                    if buttonTitles.count == 1 {
                        self.panelView => button.right == self.panelView.right - 20
                    } else {
                        self.panelView => button.right == self.panelView.centerX
                    }
                } else {
                    // 左侧布局
                    self.panelView => button.left == self.panelView.centerX
                    // 右侧布局
                    self.panelView => button.right == self.panelView.right - 20
                }
                // 底部布局
                self.panelView => button.bottom == self.panelView.bottom - 20

            } else { // 竖排

                // 顶部布局
                if i == 0 {
                    self.panelView => button.top == self.messageLabel.bottom + 10
                } else {
                    self.panelView => button.top == self.buttons.last!.bottom
                }
                // 左侧布局
                self.panelView => button.left == self.panelView.left + 20
                // 右侧布局
                self.panelView => button.right == self.panelView.right - 20
                // 底部布局
                if i == buttonTitles.count - 1 {
                    self.panelView => button.bottom == self.panelView.bottom - 20
                } else { // 添加分界线
                    let line = UIView()
                    line.backgroundColor = AHAlertView.seperatorLineColor
                    line.translatesAutoresizingMaskIntoConstraints = false
                    self.panelView.addSubview(line)

                    self.panelView => line.left == self.panelView.left + 30
                    self.panelView => line.right == self.panelView.right - 30
                    self.panelView => line.top == button.bottom
                    self.panelView => line.height == 1 / UIScreen.main.scale
                }
            }
            // 高度
            self.panelView => button.height == 40

            self.buttons.append(button)
        }

        self.keyWindow = UIWindow()
        self.keyWindow!.backgroundColor = UIColor.clear
        self.keyWindow!.frame = UIScreen.main.bounds
        self.keyWindow!.windowLevel = UIWindowLevelStatusBar
        self.keyWindow!.isHidden = true
    }

    fileprivate func makeButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.buttonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }

    open func show() {

        if self.superview == nil {

            self.panelView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

            if let viewForExtension = self.viewForExtension {
                viewForExtension.addSubview(self)
            } else {
                self.keyWindow?.addSubview(self)
                self.keyWindow?.isHidden = false
            }

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.panelView.transform = CGAffineTransform.identity
                }, completion: { (completed) in
                    
            })
        }
    }

    open var cancelButtonIndex: Int {
        get {
            return self.buttons.last?.tag ?? 0
        }
    }

    fileprivate func dismissView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.panelView.alpha = 0.0
            self.panelView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }) { (completed) in
            self.removeFromSuperview()
            self.keyWindow?.isHidden = true
        }
    }

    open func buttonAction(_ button: UIButton) {
        if let delegate = self.delegate as? AHAlertViewDelegate {
            delegate.ahAlertView(self, clickedButtonAtIndex: button.tag)
        }
        if let block = self.block {
            block(self, button.tag)
        }

        self.dismissView()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
