//
//  Keyboard.swift
//  Emojis
//
//  Created by  Kostantin Zarubin on 31.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit
import Foundation

class KeyboardView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var backspaceButton: UIButton!
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    class func instanceFromNib() -> KeyboardView {
        return UINib(nibName: "KeyboardView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! KeyboardView
    }
    
    override func awakeFromNib() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.frame.size.height = UIScreen.main.bounds.size.height / 2.7
        self.frame.size.width = UIScreen.main.bounds.size.width
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width * 0.12 , height: UIScreen.main.bounds.size.height * 0.0674)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = UIImage(named: "next_keyboard") // CHANGE IT TO REAL EMOJI
        UIPasteboard.general.image = image
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyboardCollectionViewCell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}
