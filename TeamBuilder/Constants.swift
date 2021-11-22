//
//  Constants.swift
//  TeamBuilder
//
//  Created by Артем Хребтов on 14.11.2021.
//

import Foundation
import UIKit
//вспомогательные константы для удобства
struct Constants {
    static let deviceWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    static let deviceHeight: CGFloat = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    static let cardViewInsets = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
    static let cellHeight: CGFloat = deviceHeight / 4
    static let leaderImageSize: CGSize = CGSize(width: (deviceWidth - 64) / 5 , height: cellHeight / 2)
    static let crownSize: CGSize = CGSize(width: 20, height: 20)
    static let labelHeight: CGFloat = 40
    static let teamCapasity = 5
}

