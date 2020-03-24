//
//  UIPasteboard+Ex.swift
//  FFSwiftExtension
//
//  Created by mmh on 2020/3/24.
//

import UIKit

let MMHPasteboardLastCopyTextKey = "MMHPasteboardLastCopyTextKey"

public extension UIPasteboard {
    /// 获取APP内最后一次粘贴到剪贴板中的内容
    @objc class var lastCopyStr: String? {
        get {
            return UserDefaults.standard.string(forKey: MMHPasteboardLastCopyTextKey)
        }
        set {
            if let newCopyStr = newValue {
                UserDefaults.standard.set(newCopyStr, forKey: MMHPasteboardLastCopyTextKey)
            }
        }
    }
    
    /// 复制到剪贴板
    /// ⚠️ 封装原因：pasteboard.string = nil会导致crash
    ///
    /// - Parameter content: 复制内容
    @objc class func paste(content: String?) {
        guard let copyStr = content, !copyStr.isEmpty else {
            return
        }
        let pasteboard = UIPasteboard.general
        pasteboard.string = copyStr
        UserDefaults.standard.set(copyStr, forKey: MMHPasteboardLastCopyTextKey)
    }
}
