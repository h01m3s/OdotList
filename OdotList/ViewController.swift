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
        
        testScrollView()
    }
    
    private func testScrollView() {
        let scrollView = UIScrollView(frame: view.frame)
        scrollView.backgroundColor = .blue
//        scrollView.contentSize = CGSize(width: 200, height: 200)
        scrollView.center = view.center
        
        let redView = UIView(frame: CGRect(x: scrollView.center.x, y: 50, width: 200, height: 200))
        redView.backgroundColor = .red
        let cyanView = UIView(frame: CGRect(x: scrollView.center.x, y: 300, width: 200, height: 200))
        cyanView.backgroundColor = .cyan
        scrollView.addSubview(redView)
        scrollView.addSubview(cyanView)
        view.addSubview(scrollView)
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

