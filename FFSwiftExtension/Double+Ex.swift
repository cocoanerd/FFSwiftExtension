//
//  Double+Ex.swift
//  FFSwiftExtension
//
//  Created by mmh on 2020/3/25.
//

import UIKit

public extension Double {
    /// 处理数值精度
    /// - Parameters:
    ///   - scale: 保留位数
    ///   - divide: 除以的位数
    /// - Returns: 处理后的结果
    func formatNumber(afterPoint scale: Int16, divide: Double = 1) -> String {
        //保留小数和进位规则
        let roundingBehavior = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.bankers, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        
        let decimalNumber = NSDecimalNumber.init(value: self)
        let divideNumber = NSDecimalNumber.init(value: divide)
        
        let result = decimalNumber.dividing(by: divideNumber, withBehavior: roundingBehavior)
        
        return result.stringValue
    }
    
    var scaleFloat: CGFloat {
        return CGFloat(self).scaleFloat
    }
    
    // MARK: - 加、减、乘、除
    /// 加
    /// - Parameter num: 加数
    /// - Parameter scale: 保留位数
    func add(num: Double, scale: Int16 = 2) -> Double {
        //保留小数和进位规则
        let roundingBehavior = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.bankers, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        
        let number1 = NSDecimalNumber(floatLiteral: self)
        let number2 = NSDecimalNumber(floatLiteral: num)
        let summation = number1.adding(number2, withBehavior: roundingBehavior)
        return summation.doubleValue
    }
    
    /// 减
    /// - Parameter num: 减数
    /// - Parameter scale: 保留位数
    func minus(num: Double, scale: Int16 = 2) -> Double {
        //保留小数和进位规则
        let roundingBehavior = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.bankers, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        
        let number1 = NSDecimalNumber(floatLiteral: self)
        let number2 = NSDecimalNumber(floatLiteral: num)
        let summation = number1.subtracting(number2, withBehavior: roundingBehavior)
        return summation.doubleValue
    }
    
    /// 乘
    /// - Parameter num: 乘数
    /// - Parameter scale: 保留位数
    func multiplying(num: Double, scale: Int16 = 2) -> Double {
        //保留小数和进位规则
        let roundingBehavior = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.bankers, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        
        let number1 = NSDecimalNumber(floatLiteral: self)
        let number2 = NSDecimalNumber(floatLiteral: num)
        let summation = number1.multiplying(by: number2, withBehavior: roundingBehavior)
        return summation.doubleValue
    }
    
    /// 除
    /// - Parameter num: 除数
    /// - Parameter scale: 保留位数
    func dividing(num: Double, scale: Int16 = 2) -> Double {
        //保留小数和进位规则
        let roundingBehavior = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.bankers, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        
        let number1 = NSDecimalNumber(floatLiteral: self)
        let number2 = NSDecimalNumber(floatLiteral: num)
        let summation = number1.dividing(by:number2, withBehavior: roundingBehavior)
        return summation.doubleValue
    }
}
