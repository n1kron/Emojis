//
//  ExplanationsViewController.swift
//  Emojis
//
//  Created by  Kostantin Zarubin on 05.09.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class ExplanationsViewController: UIViewController {
    
    @IBOutlet var explanationButtons: [UIButton]!
    @IBOutlet var explanationLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in explanationButtons {
            button.layer.cornerRadius = 10.0
        }
        
        if Consts.isIpad {
            for label in explanationLabels {
                label.font = label.font?.withSize(25)
            }
        }
    }
    
    @IBAction func setupAction(_ sender: Any) {
        if let url = URL(string:UIApplicationOpenSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
