//
//  CategoryViewController.swift
//  OdotList
//
//  Created by Weijie Lin on 5/17/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    let categoryImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "person").withRenderingMode(.alwaysTemplate))
        imageView.contentMode = .center
        imageView.tintColor = UIColor.orangeGradient.first
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.orangeGradient.first?.cgColor
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    private let tasksLabel: UILabel = {
        let label = UILabel()
        label.text = "0 Tasks"
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Personal"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "100%"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private let gradientProgressBar = GradientProgressBar()
    
    private func animateGradientProgressBar(progress: Double) {
        gradientProgressBar.setProgress(Float(progress), animated: true)
    }
    
    var progress: Double = 0 {
        didSet {
            animateGradientProgressBar(progress: progress)
            percentageLabel.text = "\(Int((progress * 100)))%"
        }
    }
    
    var todoCategory: ToDoCategory? {
        didSet {
            guard let category = todoCategory else { return }
            categoryImageView.image = category.categoryIcon.withRenderingMode(.alwaysTemplate)
            categoryImageView.tintColor = category.categoryGradientColors.first
            categoryImageView.layer.borderColor = category.categoryGradientColors.first?.cgColor
            categoryTitleLabel.text = category.categoryName
            gradientProgressBar.gradientColors = category.categoryGradientColors.map { $0.cgColor }
            progress = drand48()
        }
    }
    
    let tasksTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupNavBar()
        setupSubViews()
    }
    
    fileprivate func setupNavBar() {
        // TODO: add leftBarButtonItem disable swipe back gesture???
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "more"), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = UIColor(hexString: "bfbfbf")
    }
    
    fileprivate func setupSubViews() {
        view.addSubview(categoryImageView)
        categoryImageView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 55, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        view.addSubview(tasksLabel)
        tasksLabel.anchor(categoryImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 55, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        view.addSubview(categoryTitleLabel)
        categoryTitleLabel.anchor(tasksLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 55, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        view.addSubview(percentageLabel)
        percentageLabel.anchor(categoryTitleLabel.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 55, widthConstant: 35, heightConstant: 10)
        
        view.addSubview(gradientProgressBar)
        gradientProgressBar.anchor(nil, left: view.leftAnchor, bottom: nil, right: percentageLabel.leftAnchor, topConstant: 0, leftConstant: 55, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 4)
        gradientProgressBar.centerYAnchor.constraint(equalTo: percentageLabel.centerYAnchor, constant: 1).isActive = true
        
        view.addSubview(tasksTableView)
        tasksTableView.anchor(gradientProgressBar.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 24, leftConstant: 55, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        tasksTableView.separatorInset = .zero
    }
    
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}

//extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//}
