//
//  GradientProgressBar.swift
//  OdotList
//
//  Created by Weijie Lin on 5/9/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class GradientProgressBar: UIProgressView {
    
    var gradientColors: [CGColor] = UIColor.orangeGradient.map { $0.cgColor } {
        didSet {
            gradientLayer.colors = gradientColors
        }
    }
    
    var cornerRadius: CGFloat = 3 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override var progressTintColor: UIColor? {
        // Keep progressTintColor to clear
        didSet {
            if progressTintColor != UIColor.clear {
                progressTintColor = UIColor.clear
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientLayer()
    }
    
    override func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)
        updateGradientLayer()
    }
    
    private let gradientLayer = GradientLayer(gradientDirection: GradientLayer.GradientDirection.leftRight)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        
        trackTintColor = UIColor(white: 0.95, alpha: 0.95)
        progressTintColor = .clear
        setupGradientLayer()
    }
    
    private func setupGradientLayer() {
        layer.addSublayer(gradientLayer)
        gradientLayer.frame = sizeByPercentage(originalRect: bounds, width: CGFloat(progress))
        gradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
        gradientLayer.position = CGPoint(x: 0, y: 0)
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.colors = gradientColors
        gradientLayer.masksToBounds = true
    }
    
    private func updateGradientLayer() {
        gradientLayer.frame = sizeByPercentage(originalRect: bounds, width: CGFloat(progress))
        gradientLayer.cornerRadius = cornerRadius
    }
    
    private func sizeByPercentage(originalRect: CGRect, width: CGFloat) -> CGRect {
        let newSize = CGSize(width: originalRect.width * width, height: originalRect.height)
        return CGRect(origin: originalRect.origin, size: newSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
