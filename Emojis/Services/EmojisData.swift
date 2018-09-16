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
    
    var allEmojiesList: [Emojis] = []
    
    static let shared = EmojisData()
    
    func getData(page: Int) {
        switch page {
        case 1: smileysList.removeAll()
            allEmojiesList.removeAll()
        case 2: natureList.removeAll()
        case 3: foodList.removeAll()
        case 4: activityList.removeAll()
        default: return
        }
        Alamofire.request("http://emodji.site/emojies/categories/\(page)").responseJSON { [weak self] (response) in
           // print(response.error?.localizedDescription)
            if let unparsedEmojis = response.result.value as? [[String: Any]] {
                for emojis in unparsedEmojis {
                    let emojiList: Emojis = Emojis(dict: emojis)
                    
                    switch page {
                    case 1: self?.smileysList.append(emojiList)
                    self?.allEmojiesList.append(emojiList)
                    case 2: self?.natureList.append(emojiList)
                    self?.allEmojiesList.append(emojiList)
                    case 3: self?.foodList.append(emojiList)
                    self?.allEmojiesList.append(emojiList)
                    case 4: self?.activityList.append(emojiList)
                    self?.allEmojiesList.append(emojiList)
                    default: return
                    }
                }
                NotificationCenter.default.post(name: Notification.Name("emojis"), object: nil)
            }
        }
    }
}
