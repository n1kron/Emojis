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
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "KeyboardView", bundle: nil)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        delegateKeyboardView = objects.first as! KeyboardView
        
        for i in 1...4 {
            EmojisData.shared.getData(page: i)
        }
        
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
        
        NotificationCenter.default.addObserver(forName: Notification.Name("emojis"), object: nil, queue: nil) {(notification) in
            keyboardView.collectionView.reloadData()
        }
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
}

extension KeyboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EmojisData.shared.allEmojiesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width * 0.12 , height: UIScreen.main.bounds.size.width * 0.12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageUrl = URL(string: Consts.isIpad ? EmojisData.shared.allEmojiesList[indexPath.row].bigImage : EmojisData.shared.allEmojiesList[indexPath.row].smallImage)
        if let data = try? Data(contentsOf: imageUrl!) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    UIPasteboard.general.image = image
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyboardCollectionViewCell", for: indexPath) as! KeyboardCollectionViewCell
        
        let image = Consts.isIpad ? EmojisData.shared.allEmojiesList[indexPath.row].bigImage : EmojisData.shared.allEmojiesList[indexPath.row].smallImage
        cell.imageView.kf.setImage(with: URL(string: image), completionHandler: { (image, error, cacheType, imageUrl) in
        })
        
        return cell
    }
}
