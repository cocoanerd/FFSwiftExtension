//
//  UIScreen+Ex.swift
//  FFSwiftExtension
//
//  Created by mmh on 2020/3/24.
//

import UIKit

public extension UIScreen {
    /// 屏幕宽度
    static let kScreenWidth = UIScreen.main.bounds.size.width
    /// 屏幕高度
    static let kScreenHeight = UIScreen.main.bounds.size.height
    /// 底部安全区域高度
    static let kSafeBottomMargin = { () -> Int in
        if #available(iOS 11.0, *) {
            let mainWindow = UIApplication.shared.delegate?.window
            return Int(mainWindow??.safeAreaInsets.bottom ?? 0)
        }
        return 0
    }()
    /// iPhoneX判断
    static let isiPhoneX = kSafeBottomMargin > 0 ? true: false
    /// navigationBar高度
    static let kStatusBarHeight = isiPhoneX ? 44 : 20
    static let kNavigationBarHeight = isiPhoneX ? 88 : 64
    
    /// 关闭安全区域
    /// - Parameter scrollView: 滚动视图
    @objc class func closeSafeArea(_ scrollView: UIScrollView) {
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
    }
}
