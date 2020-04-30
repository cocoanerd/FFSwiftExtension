//
//  FFTabBarController.swift
//  FFSwiftExtension_Example
//
//  Created by mmh on 2020/4/30.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit


class FFTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        setTabbarItems()
    }
    
    func setTabbarItems() {
        var itemVCS = [UIViewController]()
        // 首页
        let mainPageVC = ViewController()
        let mainPageNav = UINavigationController(rootViewController: mainPageVC)
        mainPageNav.tabBarItem.image = UIImage(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        mainPageNav.tabBarItem.selectedImage = UIImage(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        mainPageNav.tabBarItem.imageInsets = UIEdgeInsets(top: 5.6, left: 0, bottom: -5.6, right: 0)
        mainPageNav.tabBarItem.title = "首页"
        itemVCS.append(mainPageNav)
        // 分类
        let classifyVC = SecondViewController()
        let classifyNav = UINavigationController(rootViewController: classifyVC)
        classifyNav.tabBarItem.image = UIImage(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        classifyNav.tabBarItem.selectedImage = UIImage(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        classifyNav.tabBarItem.imageInsets = UIEdgeInsets(top: 5.6, left: 0, bottom: -5.6, right: 0)
        classifyNav.tabBarItem.title = "分类"
        itemVCS.append(classifyNav)
        // 购物车
        let cartVC = ThirdViewController()
        let cartNav = UINavigationController(rootViewController: cartVC)
        cartNav.tabBarItem.image = UIImage(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        cartNav.tabBarItem.selectedImage = UIImage(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        cartNav.tabBarItem.imageInsets = UIEdgeInsets(top: 5.6, left: 0, bottom: -5.6, right: 0)
        cartNav.tabBarItem.title = "购物车"
        itemVCS.append(cartNav)
        // 我的
        let personCenterVC = FourthViewController()
        let personCenterNav = UINavigationController(rootViewController: personCenterVC)
        personCenterNav.tabBarItem.image = UIImage(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        personCenterNav.tabBarItem.selectedImage = UIImage(named: "")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        personCenterNav.tabBarItem.imageInsets = UIEdgeInsets(top: 5.6, left: 0, bottom: -5.6, right: 0)
        personCenterNav.tabBarItem.title = "我的"
        itemVCS.append(personCenterNav)
        
        viewControllers = itemVCS
    }
    
    
}
