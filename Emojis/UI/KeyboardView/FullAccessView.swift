//
//  FullAccessView.swift
//  Mr. Emojis
//
//  Created by  Kostantin Zarubin on 03/10/2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class FullAccessView: UIView {
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        layer.cornerRadius = 5.0
    }
}
