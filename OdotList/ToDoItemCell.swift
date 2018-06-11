//
//  ToDoItemCell.swift
//  OdotList
//
//  Created by Weijie Lin on 6/10/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

protocol ToDoItemCellDelegate {
    func didTapCheckBox(cellItem: ToDoItem)
}

class ToDoItemCell: UITableViewCell {
    
    static let identifier = String(describing: CategoryCell.self)
    
    var cellItem: ToDoItem? {
        didSet {
            guard let item = cellItem else { return }
            checkBox.on = item.isComplete
            UIView.transition(with: todoTitle, duration: 0.5, options: [.transitionCrossDissolve], animations: {
                if item.isComplete {
                    self.todoTitle.attributedText = self.makeDeletedAttributedText(text: item.title)
                } else {
                    self.todoTitle.attributedText = NSMutableAttributedString(string: item.title, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
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
        guard let item = cellItem else { return }
        delegate?.didTapCheckBox(cellItem: item)
    }
    
}
