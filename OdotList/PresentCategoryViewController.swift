//
//  PresentCategoryViewController.swift
//  OdotList
//
//  Created by Weijie Lin on 5/21/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class PresentCategoryViewController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let destination = transitionContext.view(forKey: .to) as! CategoryViewController
    }
    
}
