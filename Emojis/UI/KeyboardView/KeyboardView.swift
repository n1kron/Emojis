//
//  Keyboard.swift
//  Emojis
//
//  Created by  Kostantin Zarubin on 31.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit
import Foundation

class KeyboardView: UIView {
    
    @IBOutlet weak var backspaceButton: UIButton!
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    class func instanceFromNib() -> KeyboardView {
        return UINib(nibName: "KeyboardView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! KeyboardView
    }
    
    override func awakeFromNib() {
        self.frame.size.height = UIScreen.main.bounds.size.height / 2.7
        self.frame.size.width = UIScreen.main.bounds.size.width
    }
}
