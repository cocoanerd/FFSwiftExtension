//
//  UIFont+Ex.swift
//  FFSwiftExtension
//
//  Created by mmh on 2020/3/24.
//

import UIKit
import CoreText

public extension UILabel {
    /**
     使文字左右两端对齐
     font：字体为了计算字体宽度
     labelWidth：控件宽度
     */
    @objc func textAlignmentLeftAndRightWith(font: UIFont, labelWidth: CGFloat) {
        
        let text = (self.text ?? "") as NSString
        if 0 == text.length {
            return
        }
        
        var attrDic = [NSAttributedString.Key: Any]()
        attrDic.updateValue(font, forKey: NSAttributedString.Key.font)
        
        let size = text.boundingRect(with: CGSize(width: labelWidth, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine, .usesFontLeading], attributes: attrDic, context: nil).size
                
        var length = text.length - 1
        let lastStr = text.substring(with: NSRange(location: length, length: 1))
        var margin = (labelWidth - 10 -  size.width) / CGFloat(length)
        if lastStr == ":" || lastStr == "：" {
            length = text.length - 2
            //这个10是冒号：这个空隙，使用富文本右对齐，冒号后面会没有空隙，减去这个6实际效果就有空隙了
            margin = (labelWidth - 10 - size.width) / CGFloat(length)
        }
        
        let number = NSNumber(floatLiteral: Double(margin))
        let attribute = NSMutableAttributedString.init(string: text as String)
        attribute.addAttribute(.font, value: font, range: NSRange(location: 0, length: length))
        attribute.addAttribute(.kern, value: number, range:NSRange(location: 0, length: length))
        self.attributedText = attribute;
        
    }
}
