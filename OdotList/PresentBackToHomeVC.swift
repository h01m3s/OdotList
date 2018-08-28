//
//  PresentBackToHomeVC.swift
//  OdotList
//
//  Created by Weijie Lin on 8/26/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class PresentBackToHomeVC: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // MARK: Start
        let destination = transitionContext.viewController(forKey: .to) as! HomeViewController
        let containerView = transitionContext.containerView
        
        containerView.addSubview(destination.view)
        
        // Initial state
        
        
        // Final state
        
        let animator = UIViewPropertyAnimator(duration: 0.6, dampingRatio: 0.7) {
            
            // Final state
            
        }
        
        animator.addCompletion { (finished) in
            
            // Completion
            transitionContext.completeTransition(true)
            
        }
        
        animator.startAnimation()
        
    }
    
}
