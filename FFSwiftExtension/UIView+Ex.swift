//
//  UIView+Ex.swift
//  FFSwiftExtension
//
//  Created by mmh on 2020/3/24.
//

import UIKit
import MBProgressHUD

public extension UIView {
    
    /// 清除所有子视图
    @objc func removeAllSubview() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    /// 添加所有子视图
    /// - Parameter views: 视图数组
    @objc func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    /// 显示HUD
    @objc func showHUDView(image: UIImage? = nil, lineColor: UIColor = .lightGray) {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.bezelView.color = .clear
        hud.bezelView.style  = .solidColor
        hud.mode = .customView
        let hudView = HUDView()
        hudView.logoImage = image ?? UIImage()
        hudView.strokeColor = lineColor
        hud.customView = hudView
    }
    
    /// 隐藏HUD
    @objc func hideHUDView() {
        var hide = MBProgressHUD.hide(for: self, animated: false)
        while hide {
            hide = MBProgressHUD.hide(for: self, animated: false)
        }
    }
    
    /// 显示HUD
    /// - Parameter message: 内容信息
    @objc func showHUDView(message: String) {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.offset = CGPoint(x: 0, y: -80)
        hud.label.font = UIFont.systemFont(ofSize: 15)
        hud.bezelView.color = UIColor.black.withAlphaComponent(0.65)
        hud.bezelView.style = .solidColor
        hud.contentColor = .white
        hud.mode = .indeterminate
        hud.label.text = message
    }
    
    /// 显示吐丝
    /// - Parameter tips: 吐丝内容
    @objc func showTips(tipStr: String, offsetY: CGFloat = 0, completion: (()->Void)? = nil) {
        self.hideHUDView()
        if tipStr.isEmpty {
            return
        }
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.isUserInteractionEnabled = false
        hud.offset = CGPoint(x: 0, y: offsetY)
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 15)
        hud.bezelView.layer.cornerRadius = 5
        hud.bezelView.color = UIColor.black.withAlphaComponent(0.65)
        hud.bezelView.style = .solidColor
        hud.mode = .text
        hud.detailsLabel.text = tipStr
        hud.detailsLabel.textColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            hud.hide(animated: true)
            completion?()
        };
    }
    
    
    /// 快速添加tap点击手势
    @objc func addTapAction() {
        let sel: Selector!
        let name : String = NSStringFromClass(type(of: self))
        let newname = (name as NSString).substring(to: 2)
        if newname == "UI" {
            sel = Selector(("tapAction"))
        }else {
            sel = Selector("\(newname.lowercased())Action")
        }
        addTapAction(sel)
    }
    
    @objc func addTapAction(_ selector : Selector) {
        var vc: NSObject = self
        while true {
            vc = (vc as! UIResponder).next!
            if vc.isKind(of: UIViewController.self) {
                addTapAction(vc, selector)
                return
            }
        }
    }
    
    @objc func addTapAction(_ target : Any ,_ selector : Selector) {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: target, action: selector))
    }
    
}

// MARK: - 继承于UIView视图圆角设置
@objcMembers
public class Corners: NSObject {
    var topLeft: CGFloat
    var topRight: CGFloat
    var bottomLeft: CGFloat
    var bottomRight: CGFloat
    @objc public init(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }
    
    @objc public convenience init(radius: CGFloat) {
        self.init(topLeft: radius, topRight: radius, bottomLeft: radius, bottomRight: radius)
    }
    
    static var zero = Corners()
    
    /// 每个角的圆心
    func topLeftCenter(_ rect: CGRect) -> CGPoint {
        return CGPoint(x: topLeft, y: topLeft)
    }
    
    func topRightCenter(_ rect: CGRect) -> CGPoint {
        return CGPoint(x: rect.width - topRight, y: topRight)
    }
    
    func bottomLeftCenter(_ rect: CGRect) -> CGPoint {
        return CGPoint(x: bottomLeft, y: rect.height - bottomLeft)
    }
    
    func bottomRightCenter(_ rect: CGRect) -> CGPoint {
        return CGPoint(x: rect.width - bottomRight, y: rect.height - bottomRight)
    }
    
    func bezierPath(_ rect: CGRect) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: CGPoint(x: topLeft, y: 0))
        bezierPath.addLine(to: CGPoint(x: rect.width - topRight, y: 0))
        bezierPath.addArc(withCenter: topRightCenter(rect), radius: topRight, startAngle: -CGFloat.pi/2, endAngle: 0, clockwise: true)
        bezierPath.addLine(to: CGPoint(x: rect.width, y: rect.height - bottomRight))
        bezierPath.addArc(withCenter: bottomRightCenter(rect), radius: bottomRight, startAngle: 0, endAngle: CGFloat.pi/2, clockwise: true)
        bezierPath.addLine(to: CGPoint(x: bottomLeft, y: rect.height))
        bezierPath.addArc(withCenter: bottomLeftCenter(rect), radius: bottomLeft, startAngle: CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true)
        bezierPath.addLine(to: CGPoint(x: 0, y: topLeft))
        bezierPath.addArc(withCenter: topLeftCenter(rect), radius: topLeft, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3 / 2, clockwise: true)
        bezierPath.close()
        return bezierPath
    }
    
    func cornerLayer(_ rect: CGRect) -> CAShapeLayer {
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = rect
        cornerLayer.path = bezierPath(rect).cgPath
        return cornerLayer
    }
    
    override public var description: String {
        return "(\(topLeft),\(topRight),\(bottomLeft),\(bottomRight))"
    }
    
    override public func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? Corners else {
            return false
        }
        return topLeft == rhs.topLeft
            && topRight == rhs.topRight
            && bottomLeft == rhs.bottomLeft
            && bottomRight == rhs.bottomRight
    }
}


extension UIView: SelfAware {
    public static func awake() {
        UIView.swizzleLayoutSubviews
    }
    
    private class Key {
        static var cornerLayerKey = "cornerLayer_key"
        static var cornerKey = "corner_key"
    }
    
    fileprivate var cornerLayer: CAShapeLayer {
        get {
            if let layer = objc_getAssociatedObject(self, &Key.cornerLayerKey) as? CAShapeLayer {
                return layer
            } else {
                let layer = CAShapeLayer()
                objc_setAssociatedObject(self, &Key.cornerLayerKey, layer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return layer
            }
        }
        set {
            objc_setAssociatedObject(self, &Key.cornerLayerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc public var corner: Corners? {
        get {
            if let radius = objc_getAssociatedObject(self, &Key.cornerKey) as? Corners {
                return radius
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &Key.cornerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private static let swizzleLayoutSubviews: Void = {
        swizzlingForClass(UIView.self, originalSelector: #selector(layoutSubviews), swizzledSelector: #selector(mmh_layoutSubviews))
    }()
    
    @objc fileprivate func mmh_layoutSubviews() {
        self.mmh_layoutSubviews()
        
        let frame = self.bounds
        if let corner = self.corner,
            frame.width != 0 && frame.height != 0,
            cornerLayer.path != corner.bezierPath(frame).cgPath {
            cornerLayer.path = corner.bezierPath(frame).cgPath
            self.layer.mask = cornerLayer
        }
    }
}
