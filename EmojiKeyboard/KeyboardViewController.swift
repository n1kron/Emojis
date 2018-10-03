//
//  KeyboardViewController.swift
//  EmojiKeyboard
//
//  Created by  Kostantin Zarubin on 31.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//
import UIKit

class KeyboardViewController: UIInputViewController {

    weak var delegateKeyboardView: KeyboardView!
    var smilesArr: [UIImage] = []
    
    var smilesImageNames: [String] = []
    var hasAccess: Bool {
        get {
            if #available(iOS 11.0, *) {
                return self.hasFullAccess
            } else {
                return UIDevice.current.identifierForVendor != nil
            }
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        let nib = UINib(nibName: "KeyboardView", bundle: nil)
//        let objects = nib.instantiate(withOwner: nil, options: nil)
//        delegateKeyboardView = objects.first as? KeyboardView
        
        delegateKeyboardView = KeyboardView.instanceFromNib()
        delegateKeyboardView.collectionView.register(UINib.init(nibName: "KeyboardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "KeyboardCollectionViewCell")
        delegateKeyboardView.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(delegateKeyboardView)
        
        delegateKeyboardView.collectionView.delegate = self
        delegateKeyboardView.collectionView.dataSource = self
        fillSmilesArr()
        delegateKeyboardView.collectionView.reloadData()
        
        NSLayoutConstraint.activate([
            delegateKeyboardView.leftAnchor.constraint(equalTo: (inputView?.leftAnchor)!),
            delegateKeyboardView.topAnchor.constraint(equalTo: (inputView?.topAnchor)!),
            delegateKeyboardView.rightAnchor.constraint(equalTo: (inputView?.rightAnchor)!),
            delegateKeyboardView.bottomAnchor.constraint(equalTo: (inputView?.bottomAnchor)!)
            ])
        
        delegateKeyboardView.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        delegateKeyboardView.backspaceButton.addTarget(self, action: #selector(backspace), for: .touchUpInside)
        delegateKeyboardView.spacebarButton.addTarget(self, action: #selector(spacebar), for: .touchUpInside)
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
    
    func fillSmilesArr() {
        smilesImageNames.removeAll()
        let imageNames = (0...361).map { "emojis\($0)" }
        smilesImageNames.append(contentsOf: imageNames)
    }
    
}

extension KeyboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return smilesImageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width * 0.11 , height: UIScreen.main.bounds.size.width * 0.11 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if hasAccess {
            delegateKeyboardView.fullAccessView.descriptionLabel.text = "Сopied. Tap the text field and select <Paste>"
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                self.delegateKeyboardView.fullAccessView.alpha = 1
            }) { (finished) in
                UIView.animate(withDuration: 0.3, delay: 1, options: [], animations: {
                    self.delegateKeyboardView.fullAccessView.alpha = 0
                }, completion: nil)
            }
            let imageName = smilesImageNames[indexPath.row]
            let image = UIImage(named: imageName)
            UIPasteboard.general.image = image
        } else {
            delegateKeyboardView.fullAccessView.descriptionLabel.text = "Please, allow full access to send emoji"
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                self.delegateKeyboardView.fullAccessView.alpha = 1
            }) { (finished) in
                UIView.animate(withDuration: 0.3, delay: 1, options: [], animations: {
                    self.delegateKeyboardView.fullAccessView.alpha = 0
                }, completion: nil)
            }
        }
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
        DispatchQueue.main.async {
            let imageName = self.smilesImageNames[indexPath.row]
            let image = UIImage(named: imageName)
            cell.imageView.image = image
        }

        return cell
    }
}
