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
    
    let buttonGradientLayer = GradientLayer(gradientDirection: GradientLayer.GradientDirection.leftRight)
    lazy var addTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.setTitle("+", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 5, right: 0)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 42, weight: .thin)
        button.layer.cornerRadius = 25
//        button.clipsToBounds = true
        button.backgroundColor = .clear
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 10)
        button.addTarget(self, action: #selector(handleNewTask), for: .touchUpInside)
        return button
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
            tasksLabel.text = "\(category.categoryItems.count) Tasks"
            progress = category.completedPercentage
        }
    }
    
    lazy var tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoItemCell.self, forCellReuseIdentifier: ToDoItemCell.identifier)
        tableView.rowHeight = 45
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    @objc func handleNewTask() {
        let newTaskViewController = NewTaskViewController()
        newTaskViewController.todoCategory = todoCategory!
        navigationController?.pushViewController(newTaskViewController, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupNavBar()
        setupSubViews()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        todoCategory = CategoryStore.shared.updateCategory(category: todoCategory!)
        tasksTableView.reloadData()
    }
    
    fileprivate func setupNavBar() {
        // TODO: add leftBarButtonItem disable swipe back gesture???
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "more"), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = UIColor(hexString: "bfbfbf")
        navigationController?.navigationBar.barStyle = .default
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
        
        view.addSubview(addTaskButton)
        addTaskButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 100, rightConstant: 25, widthConstant: 50, heightConstant: 50)
        buttonGradientLayer.colors = UIColor.blueGradient.map { $0.cgColor }
        buttonGradientLayer.frame = addTaskButton.bounds
        buttonGradientLayer.shadowOpacity = 0.05
        buttonGradientLayer.shadowColor = UIColor(white: 1, alpha: 0.3).cgColor
        buttonGradientLayer.shadowOffset = CGSize(width: 0, height: 5)
        buttonGradientLayer.shadowRadius = 5
        buttonGradientLayer.cornerRadius = 25
        addTaskButton.layer.insertSublayer(buttonGradientLayer, at: 0)
    }
    
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource, ToDoItemCellDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryStore.shared.itemCount(category: todoCategory!)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = CategoryStore.shared.categoryItems(category: todoCategory!)
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoItemCell.identifier, for: indexPath) as! ToDoItemCell
        cell.delegate = self
        cell.cellItem = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = .white
        let sectionTitleLabel: UILabel = {
            let label = UILabel()
            label.text = ""
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = .lightGray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        headerView.addSubview(sectionTitleLabel)
        sectionTitleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
        
        switch section {
        case 0:
            sectionTitleLabel.text = "Today"
        case 1:
            sectionTitleLabel.text = "Tomorrow"
        default:
            sectionTitleLabel.text = "Nothing to be done"
        }
        
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func didTapCheckBox(todoItemCell: ToDoItemCell) {
        guard let cellItem = todoItemCell.cellItem else { return }
        var newItem = cellItem
        newItem.isComplete = !cellItem.isComplete
        let oldCategory = todoCategory!
        todoCategory?.edit(original: cellItem, new: newItem)
        CategoryStore.shared.edit(original: oldCategory, new: todoCategory!)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//            guard let indexPath = self.tasksTableView.indexPath(for: todoItemCell) else {
//                return
//            }
//            self.tasksTableView.reloadRows(at: [indexPath], with: .automatic)
//        }
    }
    
    func didTapSideButton(todoItemCell: ToDoItemCell, sideButtonActionType: SideButtonActionType) {
        print(sideButtonActionType)
//        guard let indexPath = tasksTableView.indexPath(for: todoItemCell) else { return }
        guard let cellItem = todoItemCell.cellItem else { return }
        switch sideButtonActionType {
        case .Delete:
            CategoryStore.shared.removeItemFromCategory(category: todoCategory!, item: cellItem)
            todoCategory = CategoryStore.shared.updateCategory(category: todoCategory!)
            // Error if two sections share same data and only delete one section
//            tasksTableView.deleteRows(at: [indexPath], with: .automatic)
            tasksTableView.reloadData()
        case .Remind:
            print("Remind Action Here...")
        default:
            print("No Action")
        }
    }
    
}
