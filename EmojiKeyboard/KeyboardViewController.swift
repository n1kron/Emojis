//
//  KeyboardViewController.swift
//  EmojiKeyboard
//
//  Created by  Kostantin Zarubin on 31.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//
import UIKit
import Kingfisher
import Alamofire

class KeyboardViewController: UIInputViewController {
    
    var delegateKeyboardView: KeyboardView!
    var smilesArr: [UIImage] = []
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "KeyboardView", bundle: nil)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        delegateKeyboardView = objects.first as? KeyboardView
        
        let keyboardView = KeyboardView.instanceFromNib()
        keyboardView.collectionView.register(UINib.init(nibName: "KeyboardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "KeyboardCollectionViewCell")
        keyboardView.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(keyboardView)
        
        keyboardView.collectionView.delegate = self
        keyboardView.collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            keyboardView.leftAnchor.constraint(equalTo: (inputView?.leftAnchor)!),
            keyboardView.topAnchor.constraint(equalTo: (inputView?.topAnchor)!),
            keyboardView.rightAnchor.constraint(equalTo: (inputView?.rightAnchor)!),
            keyboardView.bottomAnchor.constraint(equalTo: (inputView?.bottomAnchor)!)
            ])
        
        keyboardView.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        keyboardView.backspaceButton.addTarget(self, action: #selector(backspace), for: .touchUpInside)
        keyboardView.spacebarButton.addTarget(self, action: #selector(spacebar), for: .touchUpInside)
        
        fillSmilesArr(CV: keyboardView.collectionView)
    }
    
    @objc func spacebar() {
        textDocumentProxy.insertText(" ")
    }
    
    @objc func backspace() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.deleteBackward()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
    }
    
    func fillSmilesArr(CV: UICollectionView) {
        smilesArr.removeAll()
        for index in 0...49 {
            smilesArr.append(UIImage(named: "b-w\(index)")!)
        }
        
        for index in 0...99 {
            smilesArr.append(UIImage(named: "smile\(index)")!)
        }
        
        for index in 0...171 {
            smilesArr.append(UIImage(named: "obj\(index)")!)
        }
        
        for index in 0...39 {
            smilesArr.append(UIImage(named: "horror\(index)")!)
        }
        CV.reloadData()
    }
}

extension KeyboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return smilesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width * 0.12 , height: UIScreen.main.bounds.size.width * 0.12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !smilesArr.isEmpty else { return }
        UIPasteboard.general.image = self.smilesArr[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.groupTableViewBackground
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyboardCollectionViewCell", for: indexPath) as! KeyboardCollectionViewCell
        if !smilesArr.isEmpty {
            cell.imageView.image = smilesArr[indexPath.row]
        }
        return cell
    }
}
