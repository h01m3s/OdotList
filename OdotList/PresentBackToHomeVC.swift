//
//  PresentBackToHomeVC.swift
//  OdotList
//
//  Created by Weijie Lin on 8/26/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class PresentBackToHomeVC: NSObject, UIViewControllerAnimatedTransitioning {
    
    var cellFrame: CGRect!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // MARK: Start
        let destination = transitionContext.viewController(forKey: .to) as! HomeViewController
        let containerView = transitionContext.containerView
        
        containerView.addSubview(destination.view)
        
        // Initial state
        
        let translate = CATransform3DMakeTranslation(cellFrame.origin.x, cellFrame.origin.y, 0.0)
        
        destination.view.layer.transform = translate
        destination.view.frame = cellFrame
        
        containerView.layoutIfNeeded()
        
        destination.view.layer.cornerRadius = 14
        destination.view.layer.shadowOpacity = 0.3
        destination.view.layer.shadowOffset = CGSize(width: 5, height: 8)
        destination.view.layer.shadowRadius = 5
        
        // Final state
        
        let animator = UIViewPropertyAnimator(duration: 0.6, dampingRatio: 0.7) {
            
            // Final state
            destination.view.layer.transform = CATransform3DIdentity
            
            destination.view.frame = UIScreen.main.bounds
            destination.view.layer.cornerRadius = 0
            
            containerView.layoutIfNeeded()
        }
        
        animator.addCompletion { (finished) in
            
            // Completion
            transitionContext.completeTransition(true)
            
        }
        
        animator.startAnimation()
        
    }
    
}
