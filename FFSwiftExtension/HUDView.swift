//
//  HUDView.swift
//  FFSwiftExtension
//
//  Created by mmh on 2020/3/26.
//

import UIKit

let HUDViewLogoImage = UIImage(named: "icon_loading", in: Bundle(url: Bundle(for: HUDView.classForCoder()).url(forResource: "FFSwiftExtension", withExtension: "bundle")!), compatibleWith: nil)

let kHUDViewAnimationKeyRotationKey = "HUDViewAnimationKeyRotationKey.rotatioin"
let kHUDViewAnimationKeyStrokeKey = "HUDViewAnimationKeyStrokeKey.stroke"

class HUDView: UIView {
    
    var logoImage: UIImage = HUDViewLogoImage!
    var lineWidth: CGFloat = 2.0
    var duration: TimeInterval = 1.5
    var fillColor: UIColor = .clear
    var strokeColor: UIColor = .randomColor
    var layerSpace: CGFloat = 10
    var viewWidth: CGFloat = 70
    var viewHeight: CGFloat = 70
    var lineJoin: CAShapeLayerLineJoin = .bevel
    var lineCap: CAShapeLayerLineCap = .round
    var cornerRadius: CGFloat = 8
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        buildUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - BuildUI
    fileprivate func buildUI() {
        self.addSubview(logoImageView)
        self.layer.addSublayer(roundLayer)
        addAnimatioinLayer()
    }
    
    fileprivate func addAnimatioinLayer() {
        let radius = roundLayer.bounds.size.width / 2.0 - lineWidth / 2.0
        let centerX = roundLayer.bounds.size.width / 2.0
        let centerY = roundLayer.bounds.size.height / 2.0
        let startAngle = 0.0
        let endAngle = Double.pi * 2.0
        let path = UIBezierPath.init(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        path.lineCapStyle = .round
        roundLayer.path = path.cgPath
        
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation"
        animation.duration = duration / 0.5
        animation.fromValue = 0
        animation.toValue = 2 * Double.pi
        animation.repeatCount = Float(FP_INFINITE)
        animation.isRemovedOnCompletion = false
        roundLayer.add(animation, forKey: kHUDViewAnimationKeyRotationKey)
        
        let headAnimation = CABasicAnimation()
        headAnimation.keyPath = "strokeStart"
        headAnimation.duration = duration / 2
        headAnimation.fromValue = 0.0
        headAnimation.toValue = 0.1
        headAnimation.timingFunction = timingFunction
        
        let tailAnimation = CABasicAnimation()
        tailAnimation.keyPath = "strokeEnd"
        tailAnimation.duration = duration / 2
        tailAnimation.fromValue = 0.0
        tailAnimation.toValue = 1.0
        tailAnimation.timingFunction = timingFunction
        
        let endHeadAnimation = CABasicAnimation()
        endHeadAnimation.keyPath = "strokeStart"
        endHeadAnimation.beginTime = duration - headAnimation.duration
        endHeadAnimation.duration = duration / 2
        endHeadAnimation.fromValue = headAnimation.toValue
        endHeadAnimation.toValue = 1.0
        endHeadAnimation.timingFunction = timingFunction
        
        let endTailAnimation = CABasicAnimation()
        endTailAnimation.keyPath = "strokeEnd"
        endTailAnimation.beginTime = duration - tailAnimation.duration
        endTailAnimation.duration = duration / 2
        endTailAnimation.fromValue = tailAnimation.toValue
        endTailAnimation.toValue = 1.0
        endTailAnimation.timingFunction = timingFunction
        
        let animations = CAAnimationGroup()
        animations.duration = duration
        animations.animations = [headAnimation, tailAnimation, endHeadAnimation, endTailAnimation]
        animations.repeatCount = Float(FP_INFINITE)
        animations.isRemovedOnCompletion = false
        animations.fillMode = .forwards
        roundLayer.add(animations, forKey: kHUDViewAnimationKeyStrokeKey)
    }
    
    
    // MARK: - LazyCode
    fileprivate lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = self.logoImage
        imageView.frame = CGRect(x: 0, y: 0, width: imageView.image?.size.width ?? 40, height: imageView.image?.size.height ?? 40)
        imageView.center = self.center
        return imageView
    }()
    
    fileprivate lazy var roundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.contentsScale = UIScreen.main.scale
        layer.frame = CGRect(x: layerSpace, y: layerSpace, width: viewWidth, height: viewHeight)
        layer.fillColor = fillColor.cgColor
        layer.lineJoin = lineJoin
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = lineWidth
        layer.lineCap = lineCap
        return layer
    }()
    
    fileprivate lazy var timingFunction: CAMediaTimingFunction = {
        let timing = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
        return timing
    }()
}
