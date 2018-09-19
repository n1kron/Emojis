//
//  Emojis.swift
//  Emojis
//
//  Created by  Kostantin Zarubin on 06.09.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import Foundation

class Emojis {
    let id: String
    let bigImage: String
    let smallImage: String
    let title: String
    
    init(dict: [String: Any]) {
        title = dict["title"] as? String ?? ""
        bigImage = dict["big_image_url"] as? String ?? ""
        smallImage = dict["small_image_url"] as? String ?? ""
        id = dict["id"] as? String ?? ""
    }
}
