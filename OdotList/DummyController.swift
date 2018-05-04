//
//  File.swift
//  OdotList
//
//  Created by Weijie Lin on 5/3/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

class DummyController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
}

extension DummyController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
}
