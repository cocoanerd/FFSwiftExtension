//
//  UIApplication+Ex.swift
//  FFSwiftExtension
//
//  Created by mmh on 2020/3/24.
//

import UIKit

public extension UIApplication {

    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()
    
    override var next: UIResponder? {
        UIApplication.runOnce
        return super.next
    }

}

/// 遵循此协议，在程序运行时自动调用 awake 方法，使用 swizzlingForClass 交换方法
public protocol SelfAware: class {
    static func awake()
    static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector)
}

public extension SelfAware {
    static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethodOption = class_getInstanceMethod(forClass, originalSelector)
        let swizzleMethodOption = class_getInstanceMethod(forClass, swizzledSelector)
        guard let originalMethod = originalMethodOption, let swizzleMethod = swizzleMethodOption else {
            return
        }
        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod)) {
            class_addMethod(forClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzleMethod)
        }
    }
}


public class NothingToSeeHere {
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? SelfAware.Type)?.awake()
        }
        types.deallocate()
    }
}
