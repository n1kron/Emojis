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
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    
    @IBAction func nextViewAction(_ sender: Any) {
        UIView.animate(withDuration: 0.35, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: { [weak self] in
           self?.scrollView.contentOffset.x = UIScreen.main.bounds.size.width
        }, completion: nil)
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
