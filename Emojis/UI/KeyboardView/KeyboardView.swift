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
    
    @IBOutlet weak var backspaceButton: KeyboardButton!
    @IBOutlet var nextKeyboardButton: KeyboardButton!
    @IBOutlet weak var spacebarButton: KeyboardButton!
    @IBOutlet weak var alphabetButton: KeyboardButton!
    @IBOutlet weak var fullAccessView: FullAccessView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var alphabetView: UIView!
    
    @IBOutlet weak var row1: UIView!
    @IBOutlet weak var row2: UIView!
    @IBOutlet weak var row3: UIView!
    @IBOutlet weak var row4: UIView!
    
    @IBOutlet weak var charSet1: UIView!
    @IBOutlet weak var charSet2: UIView!
    
    class func instanceFromNib() -> KeyboardView {
        return UINib(nibName: "KeyboardView", bundle: nil).instantiate(withOwner: KeyboardViewController(), options: nil)[0] as! KeyboardView
    }
    
    override func awakeFromNib() {
        self.frame.size.height = UIScreen.main.bounds.size.height / 2.7
        self.frame.size.width = UIScreen.main.bounds.size.width
        alphabetButton.layer.cornerRadius = 5.0
        backspaceButton.layer.cornerRadius = 5.0
        nextKeyboardButton.layer.cornerRadius = 5.0
        spacebarButton.layer.cornerRadius = 5.0
    }
}
