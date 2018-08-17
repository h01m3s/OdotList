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
    let presentCategoryViewController = PresentCategoryViewController()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.setTitle("+", for: .normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 42, weight: .thin)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.backgroundColor = .clear
        return button
    }()
    
    fileprivate lazy var collectionViewHeight = view.frame.height / 2
    var previousCenteredCell: UICollectionViewCell?
    
    let viewGradientLayer = GradientLayer()
    let buttonGradientLayer = GradientLayer(gradientDirection: GradientLayer.GradientDirection.leftRight)

    
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        return collectionView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "deadpool"))
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    // MARK: Labels
    let dateLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 0, height: 15)
        label.text = "TODAY: \(Date().dateString())".uppercased()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let greetingLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
        label.text = "Hello, Deadpool."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    let taskLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
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
//        setupNavBar()
        setupCategoryCollectionView()
        setupLabelsAndProfileImage()
        
        
//       testButtonSetup()
        fadeInViewAnimation()
        
        dummyDataTest()
        
        navigationController?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
        setNeedsStatusBarAppearanceUpdate()
        categoryCollectionView.reloadData()
    }
    
    var todoCategories: [ToDoCategory] = []
    
    func dummyDataTest() {
        let items: [ToDoItem] = [
            .init(title: "Item 1"),
            .init(title: "Item 2"),
            .init(title: "Item 3"),
            .init(title: "Item 4"),
            .init(title: "Item 5"),
            .init(title: "Item 6")
        ]
        
        todoCategories = [
            .init(categoryName: "Personal", categoryIcon: #imageLiteral(resourceName: "person"), categoryGradientColors: UIColor.orangeGradient, todoItems: items),
            .init(categoryName: "Work", categoryIcon: #imageLiteral(resourceName: "work_icon"), categoryGradientColors: UIColor.blueGradient, todoItems: items)
                        ]
        CategoryStore.shared.append(newCategories: todoCategories)
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
        buttonGradientLayer.colors = UIColor.blueGradient.map { $0.cgColor }
        buttonGradientLayer.frame = button.bounds
        button.layer.insertSublayer(buttonGradientLayer, at: 0)
    }
    
    @objc func testButtonAnimation() {
//        UIView.animate(withDuration: 1.0) {
//            self.button.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
//            self.button.layer.cornerRadius = 0
//            self.button.center = self.view.center
//            self.buttonGradientLayer.frame = self.button.bounds
//        }
    }
    
    fileprivate func setupViewGradient() {
        viewGradientLayer.colors = UIColor.orangeGradient.map { $0.cgColor }
//        viewGradientLayer.gradientColors = UIColor.orangeGradient
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
        profileImageView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 55, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)

        // Setup Labels
        view.addSubview(dateLabel)
        dateLabel.anchor(nil, left: view.leftAnchor, bottom: categoryCollectionView.topAnchor, right: nil, topConstant: 0, leftConstant: 55, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 15)

        view.addSubview(greetingLabel)
        greetingLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: dateLabel.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 100, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)

        view.addSubview(taskLabel)
        taskLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: dateLabel.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 150, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
//        let stackView = UIStackView(arrangedSubviews: [profileImageView, greetingLabel, taskLabel, dateLabel])
//        stackView.distribution = .equalSpacing
//        stackView.axis = .vertical
//        view.addSubview(stackView)
//        stackView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: categoryCollectionView.topAnchor, right: view.rightAnchor, topConstant: 30, leftConstant: 55, bottomConstant: 0, rightConstant: 55, widthConstant: 0, heightConstant: 0)
//
//        profileImageView.anchor(stackView.topAnchor, left: stackView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
    }
    
    // MARK: Setup CategoryCollectionView
    fileprivate func setupCategoryCollectionView() {
        view.addSubview(categoryCollectionView)
        categoryCollectionView.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: collectionViewHeight + 20)
    }
    
    @objc func handleLayerChange() {
        let colorChangeAnimation = CABasicAnimation(keyPath: "colors")
        colorChangeAnimation.duration = 0.5
        if first == true {
            colorChangeAnimation.toValue = UIColor.blueGradient.map { $0.cgColor }
            first = false
        } else {
            colorChangeAnimation.toValue = UIColor.orangeGradient.map { $0.cgColor }
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
                viewGradientLayer.colors = UIColor.blueGradient.map { $0.cgColor }
            } else {
                viewGradientLayer.colors = UIColor.orangeGradient.map { $0.cgColor }
            }
            view.setNeedsLayout()
            print("layer Changed")
        }
    }

}



extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryStore.shared.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        cell.todoCategory = CategoryStore.shared.item(at: indexPath.item)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = CategoryStore.shared.item(at: indexPath.item)
        let categoryViewController = CategoryViewController()
        categoryViewController.todoCategory = selectedCategory
        
        let attributes = categoryCollectionView.layoutAttributesForItem(at: indexPath)!
        let cellFrame = categoryCollectionView.convert(attributes.frame, to: view)
        presentCategoryViewController.cellFrame = cellFrame
        
        navigationController?.pushViewController(categoryViewController, animated: true)

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
            handleLayerChange()
        }
        
        categoryCollectionView.scrollToItem(at: indexPath!, at: .centeredHorizontally, animated: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Stop scrollView sliding
        targetContentOffset.pointee = scrollView.contentOffset
    }
    
}

extension HomeViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        if operation == .push {
            if toVC is CategoryViewController {
                return presentCategoryViewController
            }
            return nil
        }
        
        return nil
    }
    
}




