//
//  ViewController.swift
//  OdotList
//
//  Created by Weijie Lin on 4/26/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    fileprivate var first = true
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.setTitle("+", for: .normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 42, weight: .thin)
        button.layer.cornerRadius = 25
        button.backgroundColor = .clear
        return button
    }()
    
    let cellId = "cellId"
    fileprivate lazy var collectionViewHeight = view.frame.height / 2
    var previousCenteredCell: UICollectionViewCell?
    
    let viewGradientLayer = GradientLayer()
    let buttonGradientLayer = GradientLayer(gradientDirection: GradientLayer.GradientDirection.leftRight)

    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "deadpool"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        return imageView
    }()
    
    // MARK: Labels
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "TODAY: \(Date().dateString())".uppercased()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, Deadpool."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    let taskLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightText
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.text = "Looks like feel good \nYou have 3 tasks to do today"
        return label
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewGradient()
        setupNavBar()
        setupCategoryCollectionView()
        setupLabelsAndProfileImage()
        
        
       testButtonSetup()
//        let today = Date()
//        print("Today: \(today.dateString(ofStyle: .medium))")
//        let tomorrow = today.adding(.day, value: 1)
//        print("Tomorrow: \(tomorrow.dateString())")
//        print("Now today: \(today.dateString())")
        fadeInViewAnimation()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    fileprivate func fadeInViewAnimation() {
        view.subviews.forEach { (view) in
            view.alpha = 0
        }
        
        UIView.animate(withDuration: 1) {
            self.view.subviews.forEach({ (view) in
                view.alpha = 1
            })
        }
    }
    
    fileprivate func testButtonSetup() {
        button.addTarget(self, action: #selector(testButtonAnimation), for: .touchUpInside)
        view.addSubview(button)
        button.anchor(nil, left: nil, bottom: categoryCollectionView.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 16, widthConstant: 50, heightConstant: 50)
        buttonGradientLayer.colors = UIColor.blueGradient
        buttonGradientLayer.frame = button.bounds
        buttonGradientLayer.cornerRadius = 25
        button.layer.insertSublayer(buttonGradientLayer, at: 0)
    }
    
    @objc func testButtonAnimation() {
        print("test button pressed")
        CATransaction.begin()
        CATransaction.setAnimationDuration(5)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut))
        UIView.animate(withDuration: 5) {
            self.button.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
            self.button.layer.cornerRadius = 0
            self.button.center = self.view.center
            self.buttonGradientLayer.frame = self.button.bounds
            self.buttonGradientLayer.cornerRadius = 0
        }
        CATransaction.commit()
    }
    
    fileprivate func setupViewGradient() {
        viewGradientLayer.colors = UIColor.orangeGradient
        viewGradientLayer.frame = view.frame
        view.layer.addSublayer(viewGradientLayer)
    }
    
    fileprivate func setupNavBar() {
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
    
    // MARK: Setup Labels
    fileprivate func setupLabelsAndProfileImage() {
        
        // profileImageView
        view.addSubview(profileImageView)
        profileImageView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 55, bottomConstant: 0, rightConstant: 0, widthConstant: 44, heightConstant: 44)
        
        // Setup Labels
        view.addSubview(dateLabel)
        dateLabel.anchor(nil, left: view.leftAnchor, bottom: categoryCollectionView.topAnchor, right: nil, topConstant: 0, leftConstant: 55, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 15)
        
        view.addSubview(greetingLabel)
        greetingLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: dateLabel.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 100, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        view.addSubview(taskLabel)
        taskLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: dateLabel.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 150, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
    }
    
    // MARK: Setup CategoryCollectionView
    fileprivate func setupCategoryCollectionView() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(categoryCollectionView)
        categoryCollectionView.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: collectionViewHeight + 20)
    }
    
    @objc func handleTap() {
        let colorChangeAnimation = CABasicAnimation(keyPath: "colors")
        colorChangeAnimation.duration = 0.5
        if first == true {
            colorChangeAnimation.toValue = UIColor.blueGradient
            first = false
        } else {
            colorChangeAnimation.toValue = UIColor.orangeGradient
            first = true
        }
        
        colorChangeAnimation.fillMode = kCAFillModeForwards
        colorChangeAnimation.isRemovedOnCompletion = false
        colorChangeAnimation.delegate = self
        viewGradientLayer.add(colorChangeAnimation, forKey: "colorChange")
    }

}

extension HomeViewController: CAAnimationDelegate {

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if first == false {
                viewGradientLayer.colors = UIColor.blueGradient
            } else {
                viewGradientLayer.colors = UIColor.orangeGradient
            }
            view.setNeedsLayout()
            print("layer Changed")
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
        let frameWidth = view.frame.width
        return CGSize(width: frameWidth * 75/100, height: collectionViewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let horizontalInset = view.frame.width * 25/100 / 2
        print(horizontalInset)
//        return UIEdgeInsetsMake(0, 34, 15, 34)
        return UIEdgeInsetsMake(0, horizontalInset, 15, horizontalInset)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("view did end dragging...")
        print(categoryCollectionView.contentOffset)

        guard var closestCell = categoryCollectionView.visibleCells.first else {
            return
        }

        for cell in categoryCollectionView.visibleCells {
            let closestCellDelta = abs(closestCell.center.x - categoryCollectionView.bounds.size.width / 2.0 - categoryCollectionView.contentOffset.x)
            let cellDelta = abs(cell.center.x - categoryCollectionView.bounds.size.width / 2.0 - categoryCollectionView.contentOffset.x)
            if cellDelta < closestCellDelta {
                closestCell = cell
            }
        }

        let indexPath = categoryCollectionView.indexPath(for: closestCell)

        if (previousCenteredCell == nil || previousCenteredCell != closestCell){
            previousCenteredCell = closestCell
            handleTap()
        }

        categoryCollectionView.scrollToItem(at: indexPath!, at: .centeredHorizontally, animated: true)
    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        // Maybe use this later with data model.
//        let nextCell = velocity.x > 0 ? categoryCollectionView.visibleCells.last! : categoryCollectionView.visibleCells.first!
//        let indexPath = categoryCollectionView.indexPath(for: nextCell)
//        categoryCollectionView.scrollToItem(at: indexPath!, at: .centeredHorizontally, animated: true)
//    }
    
}





