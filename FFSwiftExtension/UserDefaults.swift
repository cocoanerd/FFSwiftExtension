//
//  UserDefaults.swift
//  FFSwiftExtension
//
//  Created by mmh on 2020/3/24.
//

import UIKit

public extension UserDefaults {
    /// 用户信息存储用
    enum Account: String, UserDefaultSettable {
        /// 历史登录手机号
        case phone
    }
    /// 崩溃信息
    enum CrashInfo: String, UserDefaultSettable {
        case crashTime
    }
    
    /// App相关信息
    enum AppInfo: String, UserDefaultSettable {
        case userAgent
        /// 安装app时间
        case installTime
    }
}

// MARK: UserDefaultSettable
public protocol UserDefaultSettable {
    var uniqueKey: String { get }
}

public extension UserDefaultSettable where Self: RawRepresentable, Self.RawValue == String {
    
    func set(value: Any?) {
        UserDefaults.standard.setValue(value, forKey: uniqueKey)
        synchronize()
    }
    
    var value: Any? {
        return UserDefaults.standard.value(forKey: uniqueKey)
    }
    
    var stringValue: String? {
        return value as? String
    }
    
    var doubleValue: Double? {
        return value as? Double
    }
    
    var boolValue: Bool {
        return value as? Bool ?? false
    }
    
    func set(url: URL?) {
        UserDefaults.standard.set(url, forKey: uniqueKey)
        synchronize()
    }
    
    var url: URL? {
        return UserDefaults.standard.url(forKey: uniqueKey)
    }
    
    /// 唯一key
    var uniqueKey: String {
        return "\(Self.self).\(self.rawValue)"
    }
    
    /// 删除
    func removed() {
        UserDefaults.standard.removeObject(forKey: uniqueKey)
        synchronize()
    }
    
    func synchronize() {
        UserDefaults.standard.synchronize()
    }
}
