//
//  InformationViewController.swift
//  Emojis
//
//  Created by  Kostantin Zarubin on 05.09.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    @IBOutlet var infoButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in infoButtons {
            button.layer.cornerRadius = 10
        }
    }
    
    @IBAction func privacyPolicyAction(_ sender: Any) {
        openUrl(urlString: "http://104.236.106.86/politics.html") // change reference
    }
    
    @IBAction func termOfUseAction(_ sender: Any) {
        openUrl(urlString: "http://104.236.106.86/politics.html") // change reference
    }
    
    @IBAction func subscriptionAgreementAction(_ sender: Any) {
        openUrl(urlString: "http://104.236.106.86/politics.html") // change reference
    }
    
    func openUrl(urlString:String!) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
