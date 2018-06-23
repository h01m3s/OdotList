//
//  NewTaskViewController.swift
//  OdotList
//
//  Created by Weijie Lin on 6/12/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    var keyboardHeight: CGFloat = 0 {
        didSet {
            addTaskButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -keyboardHeight).isActive = true
            buttonGradientLayer.frame = addTaskButton.bounds
            addTaskButton.layoutIfNeeded()
        }
    }
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "What tasks are you planning to perform?"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor.textColor
        return label
    }()
    
    let taskTextView: UITextView = {
        let textField = UITextView()
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = UIColor.black
        textField.keyboardAppearance = .dark
        textField.tintColor = UIColor.textColor
        return textField
    }()
    
    let categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Work", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setImage(#imageLiteral(resourceName: "work_icon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor.darkGray
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsetsMake(6, -2, 6, 6)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0)
        return button
    }()
    
    let dueDateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Today", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setImage(#imageLiteral(resourceName: "remind_icon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor.darkGray
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsetsMake(6, -2, 6, 6)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0)
        return button
    }()
    
    let buttonGradientLayer = GradientLayer(gradientDirection: GradientLayer.GradientDirection.leftRight)
    
    lazy var addTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        button.setTitle("+", for: .normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 42, weight: .thin)
//        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.backgroundColor = .clear
//        button.layer.shadowOpacity = 0.3
//        button.layer.shadowRadius = 5
//        button.layer.shadowOffset = CGSize(width: 0, height: 10)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(handleAddNewTask), for: .touchUpInside)
        return button
    }()
    
    @objc func handleAddNewTask() {
        guard let taskTitle = taskTextView.text, taskTitle.count > 0 else { return }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        
        setupNavBar()
        setupSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskTextView.becomeFirstResponder()
    }
    
    fileprivate func setupSubViews() {
        // Setup questionLabel
        view.addSubview(questionLabel)
        questionLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 45, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width * 4/5, heightConstant: 30)
        
        // Setup taskTextField
        view.addSubview(taskTextView)
        taskTextView.anchor(questionLabel.bottomAnchor, left: questionLabel.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 45, widthConstant: 0, heightConstant: 100)
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        topDividerView.alpha = 0.8
        let midDividerView = UIView()
        midDividerView.backgroundColor = UIColor.lightGray
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        view.addSubview(topDividerView)
        topDividerView.anchor(taskTextView.bottomAnchor, left: taskTextView.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.3)
        
        view.addSubview(categoryButton)
        categoryButton.anchor(topDividerView.bottomAnchor, left: topDividerView.leftAnchor, bottom: nil, right: nil, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 30)
        
        view.addSubview(midDividerView)
        midDividerView.anchor(categoryButton.bottomAnchor, left: categoryButton.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.3)
        
        view.addSubview(dueDateButton)
        dueDateButton.anchor(midDividerView.bottomAnchor, left: midDividerView.leftAnchor, bottom: nil, right: nil, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 30)
        
        view.addSubview(bottomDividerView)
        bottomDividerView.anchor(dueDateButton.bottomAnchor, left: dueDateButton.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.3)
        
        view.addSubview(addTaskButton)
        addTaskButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: keyboardHeight, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        buttonGradientLayer.colors = UIColor.blueGradient.map { $0.cgColor }
        buttonGradientLayer.frame = addTaskButton.bounds
        addTaskButton.layer.insertSublayer(buttonGradientLayer, at: 0)
    }
    
    fileprivate func setupNavBar() {
        // TODO: add leftBarButtonItem disable swipe back gesture???
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close_icon"), style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationController?.navigationBar.tintColor = UIColor(hexString: "bfbfbf")
        navigationItem.title = "New Task"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        navigationController?.navigationBar.barStyle = .default
    }
    
    @objc func closeButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}
