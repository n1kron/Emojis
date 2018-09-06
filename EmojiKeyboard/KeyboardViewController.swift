//
//  KeyboardViewController.swift
//  EmojiKeyboard
//
//  Created by  Kostantin Zarubin on 31.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

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
        
        let keyboardView = KeyboardView.instanceFromNib()
        keyboardView.collectionView.register(UINib.init(nibName: "KeyboardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "KeyboardCollectionViewCell")
        keyboardView.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(keyboardView)
        
        NSLayoutConstraint.activate([
            keyboardView.leftAnchor.constraint(equalTo: (inputView?.leftAnchor)!),
            keyboardView.topAnchor.constraint(equalTo: (inputView?.topAnchor)!),
            keyboardView.rightAnchor.constraint(equalTo: (inputView?.rightAnchor)!),
            keyboardView.bottomAnchor.constraint(equalTo: (inputView?.bottomAnchor)!)
            ])
        
        keyboardView.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        keyboardView.backspaceButton.addTarget(self, action: #selector(backspace), for: .allTouchEvents)
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
