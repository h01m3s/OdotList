//
//  CategoryCell.swift
//  OdotList
//
//  Created by Weijie Lin on 5/3/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "person").withRenderingMode(.alwaysTemplate))
        imageView.contentMode = .center
        imageView.tintColor = UIColor.orangeGradient.first
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.orangeGradient.first?.cgColor
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
        label.text = "0%"
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
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup CardView and background
        baseViewSetup()
        setupSubViews()
    }
    
    private func setupSubViews() {
        addSubview(categoryImageView)
        categoryImageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 24, leftConstant: 24, bottomConstant: 0, rightConstant: 0, widthConstant: 44, heightConstant: 44)
        categoryImageView.layer.cornerRadius = 22
        
        addSubview(categoryTitleLabel)
        categoryTitleLabel.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 24, bottomConstant: 80, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        addSubview(tasksLabel)
        tasksLabel.anchor(nil, left: leftAnchor, bottom: categoryTitleLabel.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 24, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        addSubview(percentageLabel)
        percentageLabel.anchor(nil, left: nil, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 24, bottomConstant: 60, rightConstant: 24, widthConstant: 35, heightConstant: 10)
        
        addSubview(gradientProgressBar)
        gradientProgressBar.anchor(nil, left: leftAnchor, bottom: nil, right: percentageLabel.leftAnchor, topConstant: 0, leftConstant: 24, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 4)
        gradientProgressBar.centerYAnchor.constraint(equalTo: percentageLabel.centerYAnchor, constant: 1).isActive = true
    }
    
    private func baseViewSetup() {
        backgroundColor = .white
        layer.cornerRadius = 14
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        layer.shadowRadius = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

