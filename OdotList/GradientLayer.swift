//
//  GradientLayer.swift
//  OdotList
//
//  Created by Weijie Lin on 4/27/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class GradientLayer: CAGradientLayer {
    
    enum GradientDirection {
        
        typealias GradientPoint = (startPoint: CGPoint, endPoint: CGPoint)
        
        case leftRight
        case rightLeft
        case topBottom
        case bottomTop
        case topLeftBottomRight
        case bottomRightTopLeft
        case topRightBottomLeft
        case bottomLeftTopRight
        
        func directionPoint() -> GradientPoint {
            switch self {
            case .leftRight:
                return (startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
            case .rightLeft:
                return (startPoint: CGPoint(x: 1, y: 0.5), endPoint: CGPoint(x: 0, y: 0.5))
            case .topBottom:
                return (startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1))
            case .bottomTop:
                return (startPoint: CGPoint(x: 0.5, y: 1), endPoint: CGPoint(x: 0.5, y: 0))
            case .topLeftBottomRight:
                return (startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
            case .bottomRightTopLeft:
                return (startPoint: CGPoint(x: 1, y: 1), endPoint: CGPoint(x: 0, y: 0))
            case .topRightBottomLeft:
                return (startPoint: CGPoint(x: 1, y: 0), endPoint: CGPoint(x: 0, y: 1))
            case .bottomLeftTopRight:
                return (startPoint: CGPoint(x: 0, y: 1), endPoint: CGPoint(x: 1, y: 0))
            }
        }
        
    }
    
    var gradientColors: [UIColor] = [UIColor.white] {
        didSet {
            colors = gradientColors.map { $0.cgColor }
        }
    }
    
    var gradientDirection: GradientDirection? {
        didSet {
            guard let gradientDirection = gradientDirection else { return }
            startPoint = gradientDirection.directionPoint().startPoint
            endPoint = gradientDirection.directionPoint().endPoint
        }
    }
    
    init(gradientDirection: GradientDirection = .bottomLeftTopRight) {
        super.init()
        startPoint = gradientDirection.directionPoint().startPoint
        endPoint = gradientDirection.directionPoint().endPoint
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

