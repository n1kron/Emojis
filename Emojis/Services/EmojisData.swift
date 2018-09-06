//
//  EmojisData.swift
//  Emojis
//
//  Created by  Kostantin Zarubin on 06.09.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import Foundation
import Alamofire

class EmojisData {
    var smileysList: [Emojis] = []
    var natureList: [Emojis] = []
    var foodList: [Emojis] = []
    var activityList: [Emojis] = []
    static let shared = EmojisData()
    
    func getData(page: Int) {
        Alamofire.request("http://emodji.site/emojies/categories/\(page)").responseJSON { [weak self] (response) in
            if let unparsedEmojis = response.result.value as? [[String: Any]] {
                for emojis in unparsedEmojis {
                    let emojiList: Emojis = Emojis(dict: emojis)
                    if page == 1 {
                        self?.smileysList.append(emojiList)
                    } else if page == 2 {
                        self?.natureList.append(emojiList)
                    } else if page == 3 {
                        self?.foodList.append(emojiList)
                    } else if page == 4 {
                        self?.activityList.append(emojiList)
                    }
                }
                NotificationCenter.default.post(name: Notification.Name("emojis"), object: nil)
            }
        }
    }
}
