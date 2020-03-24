//
//  String+Ex.swift
//  FFSwiftExtension
//
//  Created by mmh on 2020/3/24.
//

import UIKit

public extension String {
    // MARK: - 高度计算
        
    /// 计算宽高
    /// - Parameter font: 标签字号
    /// - Parameter maxWidth: 最大宽度
    /// - Parameter lineCount: 行数
    func sizeWith(font: UIFont, maxWidth: CGFloat, lineCount:Int) -> (CGSize) {
        let maxSize = self.sizeWith(font: font, maxWidth: maxWidth)
        if lineCount <= 1 {
            return maxSize
        }
        
        var testStr = "X"
        for _ in 0..<(lineCount-1) {
            testStr += "\nX"
        }
        let testSize = testStr.sizeWith(font: font, maxWidth: maxWidth)
        let width = testSize.width
        let height = min(testSize.height, maxSize.height)
        
        return CGSize(width: width, height: height)
    }
    
    /// 计算宽高
    /// - Parameter font: 标签字号
    /// - Parameter maxWidth: 最大宽度
    func sizeWith(font: UIFont, maxWidth: CGFloat = CGFloat.greatestFiniteMagnitude) -> (CGSize) {
        let size = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let text = self as NSString
        var attrDic = [NSAttributedString.Key: Any]()
        attrDic.updateValue(font, forKey: NSAttributedString.Key.font)
        return text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attrDic, context: nil).size
    }
    
    ///计算Width
    func widthWith(font: UIFont) -> CGFloat {
        return sizeWith(font: font, maxWidth: CGFloat.greatestFiniteMagnitude).width
    }
    
    func changeLineSpacing(lineSpacing: CGFloat, font: UIFont) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        //设置段落
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.lineBreakMode = NSLineBreakMode.byCharWrapping
        attributeString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: font], range: NSMakeRange(0, attributeString.length))
        
        return attributeString
    }
    
    //MARK: - 浮点相关
        
    static func pureString(price: CGFloat) -> String {
        let tempStr = String(format: "%.2f", price)
        if tempStr.hasSuffix(".00") {
            let index = tempStr.index(tempStr.endIndex, offsetBy: -3)
            return String(tempStr[tempStr.startIndex..<index])
        } else if tempStr.hasSuffix("0") {
            let index = tempStr.index(tempStr.endIndex, offsetBy: -1)
            return String(tempStr[tempStr.startIndex..<index])
        }
        return tempStr
    }
    
    
    static func priceStr(price: CGFloat) -> String {
        return "￥" + String.pureString(price:price)
    }
    
//MARK: - 正则相关
    
    ///根据正则过滤特殊字符
    func filterCharactor(_ regexStr: String) -> String? {
        // 创建正则表达式对象
        guard let regex = try? NSRegularExpression(pattern: regexStr, options: NSRegularExpression.Options.caseInsensitive) else {
            return nil
        }
        return regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: self.utf16.count), withTemplate: "")
    }
        
    ///根据正则判断String是否符合条件
    func regexJudge(pattern: String) -> Bool {
        if NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self) {
            return true
        }
        return false
    }
}
