//
//  ToDoItemCell.swift
//  OdotList
//
//  Created by Weijie Lin on 6/10/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

protocol ToDoItemCellDelegate {
    func didTapCheckBox(todoItemCell: ToDoItemCell)
    func didTapSideButton(todoItemCell: ToDoItemCell, sideButtonActionType: SideButtonActionType)
}

enum SideButtonActionType {
    case Delete
    case Remind
    case None
}

class ToDoItemCell: UITableViewCell {
    
    static let identifier = String(describing: CategoryCell.self)
    
    private var sideButtonActionType: SideButtonActionType = .None
    
    var cellItem: ToDoItem? {
        didSet {
            guard let item = cellItem else { return }
            checkBox.setOn(item.isComplete, animated: true)
            UIView.transition(with: todoTitle, duration: 0.3, options: [.transitionCrossDissolve], animations: {
                if item.isComplete {
                    self.todoTitle.attributedText = self.makeDeletedAttributedText(text: item.title)
                    self.sideButton.isHidden = false
                    self.sideButton.setImage(#imageLiteral(resourceName: "delete_icon"), for: .normal)
                    self.sideButtonActionType = .Delete
                } else {
                    self.todoTitle.attributedText = NSMutableAttributedString(string: item.title, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
//                    self.sideButton.isHidden = item.dueDate == nil ? true : false
                    self.sideButton.setImage(#imageLiteral(resourceName: "remind_icon"), for: .normal)
                    self.sideButtonActionType = .Remind
                }
            }, completion: nil)
        }
    }
    
    var delegate: ToDoItemCellDelegate?

    lazy var checkBox: BEMCheckBox = {
        let checkBox = BEMCheckBox(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        checkBox.boxType = .square
        checkBox.tintColor = .lightGray
        checkBox.onTintColor = .lightGray
        checkBox.onFillColor = .lightGray
        checkBox.onCheckColor = .white
        checkBox.animationDuration = 0.5
        checkBox.delegate = self
        return checkBox
    }()
    
    let todoTitle: UILabel = {
        let label = UILabel()
        label.text = "Todo Title"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    lazy var sideButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.setImage(#imageLiteral(resourceName: "remind_icon"), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(didTapsideButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didTapsideButton() {
        delegate?.didTapSideButton(todoItemCell: self, sideButtonActionType: sideButtonActionType)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        
        // Setup CheckBox
        addSubview(checkBox)
        checkBox.anchorCenterYToSuperview()
        checkBox.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        
        // Setup Todo Title
        addSubview(todoTitle)
        todoTitle.anchorCenterYToSuperview()
        todoTitle.leftAnchor.constraint(equalTo: checkBox.rightAnchor, constant: 8).isActive = true
        
        // Setup Side ImageView
        addSubview(sideButton)
        sideButton.anchorCenterYToSuperview()
        sideButton.anchor(nil, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 85, widthConstant: 20, heightConstant: 20)
    }
    
    private func makeDeletedAttributedText(text: String) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        attributedText.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSUnderlineStyle.styleThick.rawValue, range: NSMakeRange(0, text.count))
        attributedText.addAttribute(NSAttributedStringKey.strikethroughColor, value: UIColor.lightGray, range: NSMakeRange(0, text.count))
        return attributedText
    }
    
}

extension ToDoItemCell: BEMCheckBoxDelegate {
    
    func didTap(_ checkBox: BEMCheckBox) {
        print("tap from checkbox")
        delegate?.didTapCheckBox(todoItemCell: self)
    }
    
}
