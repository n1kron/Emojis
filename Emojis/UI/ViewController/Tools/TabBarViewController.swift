//
//  TabBarViewController.swift
//  Emojis
//
//  Created by  Kostantin Zarubin on 06.09.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Mr. Smile"
        navigationController?.navigationBar.barTintColor = UIColor(red: 208/255, green: 247/255, blue: 232/255, alpha: 1.0)
    }
    
    override func viewDidLayoutSubviews() {
        self.edgesForExtendedLayout = UIRectEdge.bottom
        tabBar.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: tabBar.frame.size.height)
        
        super.viewDidLayoutSubviews()
    }

}
