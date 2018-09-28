//
//  ViewController.swift
//  Emojis
//
//  Created by  Kostantin Zarubin on 31.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class ObjectsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if SubscriptionManager.shared.isSubscriptionActive != true {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            self.present(storyboard.instantiateViewController(withIdentifier: "BuySubscriptionController"), animated: true, completion: nil)
        } else {
            Utiles.shared.configureFlowLayout(collectionView)
        }
    }
}

extension ObjectsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 172
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ObjectsCollectionViewCell", for: indexPath) as! ObjectsCollectionViewCell
        cell.imageView.image = UIImage(named: "obj\(indexPath.row)")
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

