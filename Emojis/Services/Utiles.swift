//
//  Utiles.swift
//  Emojis
//
//  Created by  Kostantin Zarubin on 06.09.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class Utiles {
    
    static let shared = Utiles()
    
    func configureFlowLayout(_ collectionView : UICollectionView) {
        let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        collectionViewLayout?.itemSize = CGSize(width: UIScreen.main.bounds.size.width * 0.2, height: UIScreen.main.bounds.size.width * 0.2)
        collectionViewLayout?.invalidateLayout()
    }
}

class KeyboardButton: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.lightGray : UIColor.white
        }
    }
}
