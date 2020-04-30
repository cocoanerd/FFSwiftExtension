//
//  UITabBarController+Ex.swift
//  FFSwiftExtension
//
//  Created by mmh on 2020/4/30.
//

import UIKit

public extension UITabBarController {
    
    /// 非tab页直接跳转到tab页
    /// - Parameter targetClass: 目标tab类
    @objc class func redirectToTabs(targetClass: AnyClass) {
        guard let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else {
            return
        }
        for (index, controller) in tabBarVC.children.enumerated() {
            let navVC = controller as! UINavigationController
            if navVC.classForCoder == UINavigationController.classForCoder() {
                navVC.popToRootViewController(animated: false)
            }
            if navVC.children.first?.classForCoder == targetClass {
                tabBarVC.selectedIndex = index
                break
            }
        }
    }
    
}
