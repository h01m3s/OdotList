//
//  CategoryViewController.swift
//  OdotList
//
//  Created by Weijie Lin on 5/17/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var todoCategory: ToDoCategory? {
        didSet {
            print("ToDoCategory Set.")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "more"), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = UIColor(hexString: "bfbfbf")
    }
    
    
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}
