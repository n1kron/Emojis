//
//  FirstViewController.swift
//  Emojis
//
//  Created by  Kostantin Zarubin on 06.09.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit
import Kingfisher

class SmileysViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint! // fix this
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utiles.shared.configureFlowLayout(collectionView)
        EmojisData.shared.getData(page: 1, keyboard: false)
        NotificationCenter.default.addObserver(forName: Notification.Name("emojis"), object: nil, queue: nil) { [weak self] (notification) in
            self?.collectionView.reloadData()
        }
    }
}

extension SmileysViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EmojisData.shared.smileysList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! SmileysCollectionViewCell
        let image = EmojisData.shared.smileysList[indexPath.row].bigImage
        cell.imageView.kf.setImage(with: URL(string: image), completionHandler: { (image, error, cacheType, imageUrl) in
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Tip", message: "Please use keyboard or iMessage to send it", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Use it!", style: UIAlertActionStyle.cancel, handler: { [weak self] action in
            self?.performSegue(withIdentifier: "ShowExplanation", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
