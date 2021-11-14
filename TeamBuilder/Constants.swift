//
//  Constants.swift
//  TeamBuilder
//
//  Created by Артем Хребтов on 14.11.2021.
//

import Foundation
import UIKit

struct Constants {
    static let deviceWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    static let deviceHeight: CGFloat = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    static let cardViewInsets = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
    static let cellHeight: CGFloat = deviceHeight / 6
    static let leaderImageSize: CGSize = CGSize(width: (deviceWidth - 64) / 5 , height: cellHeight / 2)
    static let crownSize: CGSize = CGSize(width: 20, height: 20)
    static let labelHeight: CGFloat = 20
    static let teamCapasity = 5
}


//struct Constants {
//    static let cardInserts = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
//    static let topViewHeight: CGFloat = 61
//    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8)
//    static let postLabelFont = UIFont.systemFont(ofSize: 15)
//    static let bottomViewHeight: CGFloat = 40
//    static let bottomViewViewHeight: CGFloat = 40
//    static let bottomViewViewWidth: CGFloat = 80
//    static let bottomViewViewsIconSize: CGFloat = 24
//    static let postLimitsLines: CGFloat = 8
//    static let postLines: CGFloat = 6
//    static let moreButtonSize = CGSize(width: 170, height: 30)
//    static let moreButtonsInserts = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
//}
