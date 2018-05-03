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
    
    let colors = [[UIColor(hexString: "F4736A").cgColor, UIColor(hexString: "F8A05A").cgColor],
                  [UIColor(hexString: "7494DD").cgColor, UIColor(hexString: "79D0E2").cgColor]]
    
    let cellId = "cellId"
    fileprivate lazy var collectionViewHeight = view.frame.height / 2
    var previousCenteredCell: UICollectionViewCell?
    let gradientLayer = GradientLayer()

    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        return layout
    }()
    
    lazy var categoryCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "deadpool"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        return imageView
    }()
    
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
        setupLabels()
        
        navigationItem.title = "TODO"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearch))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamberger_icon"), style: .plain, target: self, action: #selector(handleMore))
        
        navigationController?.navigationBar.barStyle = .black
        
        
        view.addSubview(profileImageView)
        profileImageView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 55, bottomConstant: 0, rightConstant: 0, widthConstant: 44, heightConstant: 44)
    }
    
    @objc func handleSearch() {
        print("handle search tapped")
    }
    
    @objc func handleMore() {
        print("Handle more")
    }
    
    // MARK: Setup Labels
    fileprivate func setupLabels() {
        let dateLabel: UILabel = {
            let label = UILabel()
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yyyy"
            let dateString = formatter.string(from: date)
            label.text = "TODAY: \(dateString)".uppercased()
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            return label
        }()
        
        view.addSubview(dateLabel)
        dateLabel.anchor(nil, left: view.leftAnchor, bottom: categoryCollectionView.topAnchor, right: nil, topConstant: 0, leftConstant: 55, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 15)
        
        let greetingLabel: UILabel = {
            let label = UILabel()
            label.text = "Hello, Deadpool."
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
            return label
        }()
        
        view.addSubview(greetingLabel)
        greetingLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: dateLabel.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 100, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        let taskLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor.lightText
            label.font = UIFont.systemFont(ofSize: 14)
            label.numberOfLines = 2
            label.text = "Looks like feel good \nYou have 3 tasks to do today"
            return label
        }()
        view.addSubview(taskLabel)
        taskLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: dateLabel.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 150, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
    }
    
    // MARK: Setup CategoryCollectionView
    fileprivate func setupCategoryCollectionView() {
        categoryCollectionView.backgroundColor = .clear
        categoryCollectionView.showsVerticalScrollIndicator = false
        categoryCollectionView.showsHorizontalScrollIndicator = false
//        categoryCollectionView.isPagingEnabled = true
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

class CategoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup CardView and background
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



