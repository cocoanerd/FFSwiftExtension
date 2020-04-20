//
//  Dictionary+Safe.swift
//  FFSwiftExtension
//
//  Created by mmh on 2020/4/17.
//

import UIKit

extension Dictionary {
    /// 安全添加字典 dict.set("", nil)  后面这样如果添加nil会崩溃： dict["sex"] = s
    /// - Parameters:
    ///   - key: 键
    ///   - value: 值
    mutating func set(_ key : Dictionary.Key , _ value : Dictionary.Value?) {
        if let o = value {
            self[key] =  o
        } else {
            print("Warning! Dictionary:\(self) append an nil value key is '\(key)'")
        }
    }
    
    /// 安全取值
    /// - Parameter key: 键
    func object(_ key : Dictionary.Key) -> Dictionary.Value? {
        let value = self[key]
        if value == nil {
            return nil
        }
        return value
    }
    /// 将字典值按字符串输出
    /// - Parameter key: 键
    func string(_ key : Dictionary.Key) -> String {
        let value = self[key]
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
    /// 将字典值按Int输出
    /// - Parameter key: 键
    func int(_ key : Dictionary.Key) -> Int {
        let value = self[key]
        if value == nil {
            return 0
        }
        if let s = value as? String {
            
            if let n = Int(s) {
                return n
            }else {
                print("Warning! Dictionary:\(self) int for key:'\(key)' value:'\(s)' is not cover to Int!")
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
    /// 将字典值按double输出
    /// - Parameter key: 键
    func double(_ key : Dictionary.Key) -> Double {
        let value = self[key]
        if value == nil {
            return 0.0
        }
        if let s = value as? String {
            if let n = Double(s) {
                return n
            }else {
                print("Warning! Dictionary:\(self) int for key:'\(key)' value:'\(s)' is not cover to Double!")
                return 0
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
