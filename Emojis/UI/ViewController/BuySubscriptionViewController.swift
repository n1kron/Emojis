//
//  Created by Андрей Фоменко on 14.09.2018.
//  Copyright © 2018 Андрей Фоменко. All rights reserved.
//

import UIKit
import SafariServices
import StoreKit

class BuySubscriptionViewController: UIViewController {

    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var restorePurchase: UIButton!
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    var purchaseProducts = [SKProduct]()
    
    @IBAction func cancelButton(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.present(storyboard.instantiateViewController(withIdentifier: "NavigationVC"), animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(backView.frame.width)
        let shadowPath = UIBezierPath(rect: CGRect(x: -30,
                                                   y: 0,
                                                   width: view.frame.width + 30,
                                                   height: view.frame.height))
        backView.layer.shadowRadius = 20.0
        
        backView.layer.shadowColor = UIColor(red: 229 / 255, green: 210 / 255, blue: 5 / 255, alpha: 1.0).cgColor
        backView.layer.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat(-50))
        backView.layer.masksToBounds = false
        backView.layer.shadowOpacity = Float(10)
        backView.layer.shadowPath = shadowPath.cgPath
        
        buyButton.layer.borderWidth = 2
        buyButton.layer.borderColor = UIColor.white.cgColor
        
        loadProducts()
        NotificationCenter.default.addObserver(self, selector: #selector(handleInAppPurchase(notification:)), name: .SubscriptionStatusNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        infoTextView.flashScrollIndicators()
        infoTextView.setContentOffset(.zero, animated: true)
    }
    
    @objc func handleInAppPurchase(notification: Notification) {
        guard let result = notification.object as? Bool else  { return }
        if result {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func loadProducts() {
        
        let productIds = [SubscriptionManager.weekProductID]
        SubscriptionManager.shared.requestProducts(productIds) { products in
            self.purchaseProducts = products
        }
    }
    
    @IBAction func restoreButtonPressed(_ sender: Any) {
        SubscriptionManager.shared.resfreshReceipt()
    }
    
    @IBAction func buyButtonPressed(_ sender: Any) {
        
        SubscriptionManager.shared.buyProduct(id: SubscriptionManager.weekProductID)
    }

}
