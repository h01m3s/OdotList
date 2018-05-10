//
//  CategoryCell.swift
//  OdotList
//
//  Created by Weijie Lin on 5/3/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    let categoryImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "person").withRenderingMode(.alwaysTemplate))
        imageView.contentMode = .center
        imageView.tintColor = UIColor.orangeGradient.first
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.orangeGradient.first?.cgColor
        return imageView
    }()
    
    let tasksLabel: UILabel = {
        let label = UILabel()
        label.text = "9 Tasks"
        label.textColor = UIColor.lightGray
        return label
    }()
    
    let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Personal"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let gradientProgressBar = GradientProgressBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup CardView and background
        baseViewSetup()
        setupSubViews()
    }
    
    fileprivate func setupSubViews() {
        addSubview(categoryImageView)
        categoryImageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 24, leftConstant: 24, bottomConstant: 0, rightConstant: 0, widthConstant: 44, heightConstant: 44)
        categoryImageView.layer.cornerRadius = 22
        
        addSubview(categoryTitleLabel)
        categoryTitleLabel.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 24, bottomConstant: 80, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        addSubview(tasksLabel)
        tasksLabel.anchor(nil, left: leftAnchor, bottom: categoryTitleLabel.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 24, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        addSubview(gradientProgressBar)
        gradientProgressBar.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 24, bottomConstant: 60, rightConstant: 24, widthConstant: 0, heightConstant: 8)
    }
    
    fileprivate func baseViewSetup() {
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

//class GradientProgressBar: UIProgressView {
//
//    var cornerRadius: CGFloat = 0 {
//        didSet {
//            layer.cornerRadius = cornerRadius
//            clipsToBounds = true
//        }
//    }
//
//    private let gradientLayer = GradientLayer(gradientDirection: GradientLayer.GradientDirection.leftRight)
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        layer.addSublayer(gradientLayer)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
