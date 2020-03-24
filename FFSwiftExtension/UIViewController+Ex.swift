//
//  UIViewController+Ex.swift
//  FFSwiftExtension
//
//  Created by mmh on 2020/3/24.
//

import UIKit

public extension UIViewController {

    /**
     * UIViewController 的扩展类 获取当前的ViewController
     * 使用时只需let nowVC = UIViewController.currentViewController()
     */
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
    
}
