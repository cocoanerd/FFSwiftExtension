//
//  DetailViewController.swift
//  FFSwiftExtension_Example
//
//  Created by mmh on 2020/3/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import FFSwiftExtension

class DetailViewController: UIViewController {
    
    enum componentType: Int {
        case Button = 0
        case Color
        case Label
        case PasteBoard
        case View
        case UserDefaults
        case AtributedString
        case String
    }
    
    var type: Int

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "DetailViewController"
        view.backgroundColor = UIColor.randomColor
        doSomething()
    }
    
    init(type: Int) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func doSomething() {
        switch self.type {
        case componentType.Button.rawValue:
            view.addSubview(testButton)
            testButton.isHidden = false
            break
        case componentType.Color.rawValue:
            view.backgroundColor = .randomColor
            view.backgroundColor = UIColor.RGB(134, 344, 343)
            view.backgroundColor = UIColor.color(hexString: "333333")
            view.backgroundColor = UIColor.color(hexString: "333333", alpha: 0, defaultColor: .white)
            break
        case componentType.Label.rawValue:
            view.addSubview(testLabel1)
            view.addSubview(testLabel2)
            testLabel1.isHidden = false
            testLabel2.isHidden = false
            break
            
        case componentType.PasteBoard.rawValue:
            UIPasteboard.paste(content: "我就是粘贴板上的内容，哈哈")
            view.addSubview(testTextField)
            testTextField.isHidden = false
            break

        case componentType.View.rawValue:
            view.addSubview(testView)
            testView.isHidden = false
            break

        case componentType.UserDefaults.rawValue:
            let dic = ["number":"123"]
            UserDefaults.standard.setValue(dic, forKey: "dic_key")
            UserDefaults.standard.synchronize()
            view.addSubview(testTextField)
            testTextField.isHidden = false
            let receiveDic = UserDefaults.standard.dictionary(forKey: "dic_key")
            testTextField.text = "这就是存储的number的值：" + (receiveDic?["number"] as! String)
            break

        case componentType.AtributedString.rawValue:
            view.addSubview(attributeLabel)
            attributeLabel.isHidden = false
            break

        case componentType.String.rawValue:
            view.addSubview(testLabel1)
            testLabel1.isHidden = false
            let str = "本来我的高度不是这样的哦本来我的高度不是这样的哦本来我的高度不是这样的哦本来我的高度不是这样的哦本来我的高度不是这样的哦本来我的高度不是这样的哦本来我的高度不是这样的哦本来我的高度不是这样的哦"
            let labelHeight = str.sizeWith(font: UIFont.systemFont(ofSize: 16), maxWidth: 200).height
            testLabel1.frame = CGRect(x: 0, y: 150, width: 200, height:  labelHeight)
            testLabel1.text = str
            break
            
        default:
            break
        }
    }
    
    @objc fileprivate func buttonEvent() {
        let alert = UIAlertController.init(title: "你点击了btn", message: "我的响应范围是不是超乎你的想想", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "我知道了", style: .cancel) { (action) in
            alert.removeFromParentViewController()
        }
        alert.addAction(action)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    

    // MARK: - lazyCode
    fileprivate lazy var testButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: UIScreen.kScreenWidth/2, height: 50)
        button.center = CGPoint(x: self.view.center.x, y:CGFloat( UIScreen.kNavigationBarHeight + UIScreen.kStatusBarHeight))
        button.setTitle("我的响应范围很大哦", for: .normal)
        button.setTitleColor(.randomColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.backgroundColor = .randomColor
        button.addTarget(self, action: #selector(buttonEvent), for: .touchUpInside)
        button.isHidden = true
        button.expandClickArea = ExpandEdgeInsets.init(top: 0, left: 100, bottom: 150, right:100)
        return button
    }()
    
    fileprivate lazy var testLabel1: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 150, width: 200, height: 40)
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont .systemFont(ofSize: 16)
        label.text = "左右对齐:"
        label.isHidden = true
        label.textAlignmentLeftAndRightWith(font: UIFont.systemFont(ofSize: 16, weight: .bold), labelWidth: 200)
        label.backgroundColor = .randomColor
        return label
    }()
    
    fileprivate lazy var testLabel2: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 190, width: 200, height: 40)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "我是两端对齐:"
        label.isHidden = true
        label.textAlignmentLeftAndRightWith(font: UIFont.systemFont(ofSize: 16, weight: .bold), labelWidth: 200)
        label.backgroundColor = .randomColor
        return label
    }()
    
    fileprivate lazy var testTextField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 150, width: UIScreen.kScreenWidth, height: 100)
        textField.attributedPlaceholder = NSAttributedString.init(string: "请点击我粘贴吧", attributes: [NSAttributedStringKey.font:UIFont .systemFont(ofSize: 16, weight: .regular),NSAttributedStringKey.foregroundColor: UIColor.randomColor])
        textField.textColor = UIColor.randomColor
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.borderStyle = .none
        textField.backgroundColor = UIColor.randomColor
        textField.textAlignment = .left
        textField.isHidden = true
        return textField
    }()
    
    fileprivate lazy var testView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 150, width: UIScreen.kScreenWidth, height: 60)
        view.corner = Corners.init(radius: 8)
        view.backgroundColor = .randomColor
        view.isHidden = true
        return view
    }()
    
    fileprivate lazy var attributeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 150, width: 200, height: 500)
        label.textColor = .black
        label.numberOfLines = 0
        
        let textStr = "My name is Alex. My Phone number is 15738829238"
        let filterStr = "My name is Alex. My Phone number is "
        let attrStr = NSMutableAttributedString.init(string: textStr)
        attrStr.setFont(font: UIFont.systemFont(ofSize: 16, weight: .regular))
        attrStr.setFont(font: UIFont.systemFont(ofSize: 30, weight: .semibold), range: NSRange(location: filterStr.count, length: 11))
        attrStr.setParagraphStyle(lineSpacing: 5)
        attrStr.setFontColor(color: .randomColor, range: NSRange(location: filterStr.count, length: 11))
        label.attributedText = attrStr
        label.isHidden = true
        label.backgroundColor = .randomColor
        return label
    }()
}
