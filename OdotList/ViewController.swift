//
//  ViewController.swift
//  OdotList
//
//  Created by Weijie Lin on 4/26/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var first = true
    
    let colors = [[UIColor(hexString: "F4736A").cgColor, UIColor(hexString: "F8A05A").cgColor],
                  [UIColor(hexString: "79D0E2").cgColor, UIColor(hexString: "7494DD").cgColor]]
    
    let gradientLayer = GradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientLayer.colors = colors.first
        gradientLayer.frame = view.frame
        view.layer.addSublayer(gradientLayer)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        let colorChangeAnimation = CABasicAnimation(keyPath: "colors")
        colorChangeAnimation.duration = 0.5
        if first == true {
            colorChangeAnimation.toValue = colors.last
            first = false
        } else {
            colorChangeAnimation.toValue = colors.first
            first = true
        }
        
        colorChangeAnimation.fillMode = kCAFillModeForwards
        colorChangeAnimation.isRemovedOnCompletion = false
        colorChangeAnimation.delegate = self
        gradientLayer.add(colorChangeAnimation, forKey: "colorChange")
    }

}

extension ViewController: CAAnimationDelegate {

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            print("Done")
            if first == false {
                gradientLayer.colors = colors.last
            } else {
                gradientLayer.colors = colors.first
            }
            view.setNeedsLayout()
        }
    }

}

