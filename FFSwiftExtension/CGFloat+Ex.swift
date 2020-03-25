//
//  CGFloat+Ex.swift
//  FFSwiftExtension
//
//  Created by mmh on 2020/3/25.
//

import UIKit

public extension CGFloat {
    var scaleFloat: CGFloat {
        return self / 375.0 * UIScreen.main.bounds.size.width
    }
}
