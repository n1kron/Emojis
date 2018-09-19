//
//  OnboardingViewController.swift
//  Mr. Emoji
//
//  Created by  Kostantin Zarubin on 08.09.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var onboardingScrollView: UIScrollView!
    var transitionСompleted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingScrollView.delegate = self
    }
    
    @IBAction func nextTapAction(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.35, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: { [weak self] in
            self?.onboardingScrollView.contentOffset.x += UIScreen.main.bounds.size.width
        }
    )}
    
    @IBAction func startTapAction(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowApp", sender: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)  {
        if scrollView.contentOffset.x > scrollView.contentSize.width - scrollView.bounds.width + scrollView.contentInset.right + 10 && !transitionСompleted {
            transitionСompleted = true
            performSegue(withIdentifier: "ShowApp", sender: nil)
        }
    }
}
