//
//  UIButton+Ex.swift
//  Pods-FFSwiftExtension_Example
//
//  Created by mmh on 2020/3/24.
//

import UIKit
public extension UIButton {
    /// 设置图片在右边
    /// - Parameter space: 间距
     @objc func iconToRight(space: CGFloat) {
         //这里要获取image的宽度才可以的哦
         let img_W = self.imageView?.image?.size.width ?? 0
         
         let tit_W = self.titleLabel?.frame.size.width ?? 0
         
         var titleEdgeInsets = UIEdgeInsets()
         titleEdgeInsets.top = 0
         titleEdgeInsets.left = -(img_W + space / 2)
         titleEdgeInsets.bottom = 0
         titleEdgeInsets.right = img_W + space / 2
         self.titleEdgeInsets = titleEdgeInsets

         var imageEdgeInsets = UIEdgeInsets()
         imageEdgeInsets.top = 0
         imageEdgeInsets.left = tit_W + space / 2
         imageEdgeInsets.bottom = 0
         imageEdgeInsets.right = -(tit_W + space / 2)
         self.imageEdgeInsets = imageEdgeInsets

         var contentEdgeInsets = self.contentEdgeInsets
         contentEdgeInsets.left += space / 2
         contentEdgeInsets.right += space/2
         self.contentEdgeInsets = contentEdgeInsets
     }
     
    /// 默认文字在右添加间隔
    /// - Parameter space: 间距
    @objc func space(_ space: CGFloat) {
         var titleEdgeInsets = self.titleEdgeInsets
         titleEdgeInsets.left = titleEdgeInsets.left + space
         titleEdgeInsets.right = titleEdgeInsets.right - space
         self.titleEdgeInsets = titleEdgeInsets

         var contentEdgeInsets = self.contentEdgeInsets
         contentEdgeInsets.right += space
         self.contentEdgeInsets = contentEdgeInsets
     }
    
}


// MARK: - 扩大按钮的点击区域
@objcMembers
public class ExpandEdgeInsets: NSObject {
    var top: CGFloat
    var left: CGFloat
    var bottom: CGFloat
    var right: CGFloat
    public init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }

    public convenience init(edge: CGFloat = 0) {
        self.init(top: edge, left: edge, bottom: edge, right: edge)
    }
}

public extension UIButton {
    
    private struct ExpandeResponseAreaKey {
        static var key = "button_expand_response_area"
    }
    /// 需要扩充的点击边距
    @objc var expandClickArea: ExpandEdgeInsets? {
        get {
            if let radius = objc_getAssociatedObject(self, &ExpandeResponseAreaKey.key) as? ExpandEdgeInsets {
                return radius
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &ExpandeResponseAreaKey.key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

    }
    // 重写系统方法修改点击区域
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)
        var bounds = self.bounds
        if (expandClickArea != nil) {
            let x: CGFloat = -(expandClickArea?.left ?? 0)
            let y: CGFloat = -(expandClickArea?.top ?? 0)
            let width: CGFloat = bounds.width + (expandClickArea?.left ?? 0) + (expandClickArea?.right ?? 0)
            let height: CGFloat = bounds.height + (expandClickArea?.top ?? 0) + (expandClickArea?.bottom ?? 0)
            bounds = CGRect(x: x, y: y, width: width, height: height) //负值是方法响应范围
        }
        return bounds.contains(point)
    }
}
