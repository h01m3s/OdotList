//
//  CategoryCell.swift
//  OdotList
//
//  Created by Weijie Lin on 5/3/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

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
