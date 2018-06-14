//
//  PresentCategoryViewController.swift
//  OdotList
//
//  Created by Weijie Lin on 5/21/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class PresentCategoryViewController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var cellFrame: CGRect!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // MARK: Start
        let destination = transitionContext.viewController(forKey: .to) as! CategoryViewController
        let containerView = transitionContext.containerView

        containerView.addSubview(destination.view)

        // Initial state

//        let widthConstraint = destination.view.widthAnchor.constraint(equalToConstant: cellFrame.width)
//        let heightConstraint = destination.view.heightAnchor.constraint(equalToConstant: cellFrame.height)
//
//        NSLayoutConstraint.activate([widthConstraint, heightConstraint])

        let translate = CATransform3DMakeTranslation(cellFrame.origin.x, cellFrame.origin.y, 0.0)

        destination.view.layer.transform = translate
        destination.view.frame = cellFrame

        containerView.layoutIfNeeded()
        
        destination.view.layer.cornerRadius = 14
        destination.view.layer.shadowOpacity = 0.3
        destination.view.layer.shadowOffset = CGSize(width: 5, height: 8)
        destination.view.layer.shadowRadius = 5

        let animator = UIViewPropertyAnimator(duration: 0.6, dampingRatio: 0.7) {

            // Final state

//            NSLayoutConstraint.deactivate([widthConstraint, heightConstraint])

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
        // MARK: End
    }
    
}
