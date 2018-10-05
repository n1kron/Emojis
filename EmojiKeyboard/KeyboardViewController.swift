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
    
    var capsLockOn = true
    
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
        
        delegateKeyboardView = KeyboardView.instanceFromNib()
        delegateKeyboardView.charSet2.isHidden = true
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
        
        if !hasAccess {
            delegateKeyboardView.fullAccessView.descriptionLabel.text = "Please, allow full access to send emoji.\n Settings -> General -> Keyboard -> Keyboards -> Add new keyboard"
            delegateKeyboardView.fullAccessView.alpha = 1
        }
    }
    
    @IBAction func spacebarAction(_ sender: Any) {
        textDocumentProxy.insertText(" ")
    }
    
    @IBAction func alphabetAction(_ sender: Any) {
        delegateKeyboardView.alphabetView.isHidden = !delegateKeyboardView.alphabetView.isHidden
    }
    
    @IBAction func backspaceAction(_ sender: Any) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    @IBAction func keyPressed(button: UIButton) {
        let string = button.titleLabel!.text
        (textDocumentProxy as UIKeyInput).insertText("\(string!)")
        
        button.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.2, animations: {
            button.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }, completion: {(_) -> Void in
            button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    @IBAction func capsLockPressed(button: UIButton) {
        capsLockOn = !capsLockOn
        
        changeCaps(containerView: delegateKeyboardView.row1)
        changeCaps(containerView: delegateKeyboardView.row2)
        changeCaps(containerView: delegateKeyboardView.row3)
        changeCaps(containerView: delegateKeyboardView.row4)
    }
    
    @IBAction func charSetPressed(button: UIButton) {
        if button.titleLabel!.text == "1/2" {
            delegateKeyboardView.charSet1.isHidden = true
            delegateKeyboardView.charSet2.isHidden = false
            button.setTitle("2/2", for: .normal)
        } else if button.titleLabel!.text == "2/2" {
            delegateKeyboardView.charSet1.isHidden = false
            delegateKeyboardView.charSet2.isHidden = true
            button.setTitle("1/2", for: .normal)
        }
    }
    
    @IBAction func returnPressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    func changeCaps(containerView: UIView) {
        for view in containerView.subviews {
            if let button = view as? UIButton {
                if let buttonTitle = button.titleLabel?.text {
                    if capsLockOn {
                        let text = buttonTitle.uppercased()
                        button.setTitle("\(text)", for: .normal)
                    } else {
                        let text = buttonTitle.lowercased()
                        button.setTitle("\(text)", for: .normal)
                    }
                }
            }
        }
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
