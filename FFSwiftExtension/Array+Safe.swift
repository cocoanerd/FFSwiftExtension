//
//  Array+Safe.swift
//  FFSwiftExtension
//
//  Created by mmh on 2020/4/17.
//

import UIKit

public extension Array {
    /// 安全的下标取值 arr[5]这样会崩溃，arr[safe: 5]这样不会
    /// - Parameter index: 下标
    subscript (safe index: Int) -> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
    
    /// 省去非空判断，添加元素
    /// - Parameter safeObject: 添加的内容
    mutating func add(_ safeObject: Iterator.Element?) {
        if let obj = safeObject {
            self.append(obj)
        }else {
            print("Warning! Array:\(self) add an nil element")
        }
    }
    
    /// 安全的下标取值 arr[5]这样会崩溃，arr.objectAt(5)这样不会
    /// - Parameter index: 下标
    func objectAt(_ index : Int) -> Iterator.Element? {
        if index < self.count {
            return self[index]
        }else {
            print("Warning! Array:\(self) object index:'\(index)' out of bunds (0 , \(self.count))")
            return nil
        }
    }
    
    /// 将数组number元素转为string
    /// - Parameter index: 下标
    func stringAt(_ index : Int) -> String {
        let value = self.objectAt(index)
        if value == nil {
            return ""
        }
        if let s = value as? String {
            return s
        }
        if let i = value as? Int {
            return i.description
        }
        if let d = value as? Double {
            return d.description
        }
        return ""
    }
    
    /// 将数组字符串元素转为int
    /// - Parameter index: 下标
    func intAt(_ index : Int) -> Int {
        let value = self.objectAt(index)
        if value == nil {
            return 0
        }
        if let s = value as? String {
         
            if let n = Int(s) {
                return n
            }else {
                print("Warning! Array:\(self)  int at index:'\(index)' value:'\(s)' is not cover to Int!")
                return 0
            }
        }
        if let i = value as? Int {
            return i
        }
        if let d = value as? Double {
            return Int(d)
        }
        return 0
    }
    /// 将数组字符串元素转为double
    /// - Parameter index: 下标
    func doubleAt(_ index : Int) -> Double {
        let value = self.objectAt(index)
        if value == nil {
            return 0.0
        }
        if let s = value as? String {
            if let n = Double(s) {
                return n
            }else {
                print("Warning! Array:\(self)  int at index:'\(index)' value:'\(s)' is not cover to Double!")
                return 0.0
            }
        }
        if let i = value as? Int {
            return Double(i)
        }
        if let d = value as? Double {
            return d
        }
        return 0.0
    }
    
}
