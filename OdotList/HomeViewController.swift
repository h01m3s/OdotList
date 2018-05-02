//
//  ViewController.swift
//  OdotList
//
//  Created by Weijie Lin on 4/26/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var first = true
    
    let colors = [[UIColor(hexString: "F4736A").cgColor, UIColor(hexString: "F8A05A").cgColor],
                  [UIColor(hexString: "7494DD").cgColor, UIColor(hexString: "79D0E2").cgColor]]
    
    let cellId = "cellId"
    let gradientLayer = GradientLayer()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientLayer.colors = colors.first
        gradientLayer.frame = view.frame
        view.layer.addSublayer(gradientLayer)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
        setupCategoryCollectionView()
        
        navigationItem.title = "TODO"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearch))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamberger_icon"), style: .plain, target: self, action: #selector(handleMore))
        
        navigationController?.navigationBar.barStyle = .black
    }
    
    @objc func handleSearch() {
        print("handle search tapped")
    }
    
    @objc func handleMore() {
        print("Handle more")
    }
    
    // MARK: Setup CategoryCollectionView
    fileprivate func setupCategoryCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        let categoryCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        categoryCollectionView.backgroundColor = .clear
        categoryCollectionView.showsVerticalScrollIndicator = false
        categoryCollectionView.showsHorizontalScrollIndicator = false
        let collectionViewHeight = (view.frame.height / 2)
        print("collectionViewHeight: \(collectionViewHeight)")
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(categoryCollectionView)
        categoryCollectionView.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: collectionViewHeight + 30)
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

extension HomeViewController: CAAnimationDelegate {

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if first == false {
                gradientLayer.colors = colors.last
            } else {
                gradientLayer.colors = colors.first
            }
            view.setNeedsLayout()
            print("Done")
        }
    }

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 370)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 28, 0, 28)
    }
    
}

class CategoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup CardView and background
        backgroundColor = .white
        layer.cornerRadius = 14
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

