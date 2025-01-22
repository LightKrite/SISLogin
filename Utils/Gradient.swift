//
//  Gradient.swift
//  SISLoginTEST
//
//  Created by Егор Партенко on 22.1.25..
//
import UIKit

extension UIView {
    func addGradient(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0, y: 0.5), endPoint: CGPoint = CGPoint(x: 1, y: 0.5)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds
        
        // Важно: при изменении размера view обновляем frame градиента
        layer.sublayers?.forEach { if $0 is CAGradientLayer { $0.removeFromSuperlayer() } }
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
