//
//  UIColor+Ex.swift
//  FFSwiftExtension
//
//  Created by mmh on 2020/3/24.
//

import UIKit

public extension UIColor {
    
    /// 生成随机颜色
    @objc class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    /// 根据rgb获取颜色
    /// - Parameter r: red
    /// - Parameter g: green
    /// - Parameter b: blue
    /// - Parameter a: 透明度
    /// - Returns: UIColor
    @objc class func RGB(_ r: CGFloat, _ g: CGFloat, _ b:CGFloat, _ a: CGFloat = 1) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    /// 十六进制转UIColor
    /// - Parameter hexString: 十六进制色值
    /// - Parameter alpha: 透明度
    /// - Returns: UIColor
    @objc class func color(hexString: String?, alpha: CGFloat = 1, defaultColor: UIColor? = .white) -> UIColor {
        guard var pureHexString = hexString?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased() else {
            return defaultColor ?? .white
        }
        
        if pureHexString.hasPrefix("0X") {
            pureHexString = NSString(string: pureHexString).substring(from: 2)
        } else if pureHexString.hasPrefix("#") {
            pureHexString = NSString(string: pureHexString).substring(from: 1)
        }
        
        if pureHexString.count != 6 {
            return defaultColor ?? .white
        }
        
        var range = NSRange(location: 0, length: 2)
        let rString = NSString(string: pureHexString).substring(with: range)
        range.location += range.length
        let gString = NSString(string: pureHexString).substring(with: range)
        range.location += range.length
        let bString = NSString(string: pureHexString).substring(with: range)
        
        // 存储转换后的数值
        var red:UInt32 = 0, green:UInt32 = 0, blue:UInt32 = 0
        
        Scanner(string: rString).scanHexInt32(&red)
        Scanner(string: gString).scanHexInt32(&green)
        Scanner(string: bString).scanHexInt32(&blue)

        return RGB(CGFloat(red), CGFloat(green), CGFloat(blue), alpha)
    }
    
    /// 十六进制转UIColor
    /// - Parameter hexString: 16进制色值
    @objc class func hexString(hexString: String?) -> UIColor {
        return color(hexString: hexString, alpha: 1, defaultColor: .white)
    }
    
    /// 颜色变化
    /// - Parameter from: 开始颜色
    /// - Parameter to: 结束颜色
    /// - Parameter percent: 百分比
    @objc class func color(fromColor from: UIColor, toColor to: UIColor, percent: CGFloat) -> UIColor {
        if percent == 0 { return from }
        if percent == 1 { return to }
        if from == to { return from }
        //起始
        var fromRed: CGFloat = 0
        var fromGreen: CGFloat = 0
        var fromBlue: CGFloat = 0
        var fromAlpha: CGFloat = 0
        
        //结束
        var toRed: CGFloat = 0
        var toGreen: CGFloat = 0
        var toBlue: CGFloat = 0
        var toAlpha: CGFloat = 0
        
        if from.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha) &&
            to.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha) {
            
            let resultRed = (toRed - fromRed) * percent + fromRed
            let resultGreen = (toGreen - fromGreen) * percent + fromGreen
            let resultBlue = (toBlue - fromBlue) * percent + fromBlue
            let resultAlpha = (toAlpha - fromAlpha) * percent + fromAlpha
            
            return UIColor(red: resultRed, green: resultGreen, blue: resultBlue, alpha: resultAlpha)
        }
        return to
    }
}
