//
//  AddTeamMemberCell.swift.swift
//  TeamBuilder
//
//  Created by Артем Хребтов on 16.11.2021.
//

import Foundation
import UIKit
import SnapKit

class AddTeamMemberCell: UITableViewCell {
    static let reuseId = "Cell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        uiConfiguration()
    }
        required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    let avatar: AvatarImage = {
        let image = AvatarImage()
        image.backgroundColor = .yellow
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "avatar")
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let leaderStar: UIImageView = {
        let image = UIImageView()
        image.tintColor = .yellow
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var memberName = UILabel()
    let memberPhrase = UILabel()
    let leftItem = UILabel()
    let rightItem = UILabel()
    let name = UILabel()
    let phrase = UILabel()
    let slot1 = UILabel()
    let slot2 = UILabel()
      
    func uiConfiguration() {
        //Добавили кастомный cardView
        contentView.addSubview(cardView)
        contentView.addSubview(memberName)
        contentView.addSubview(memberPhrase)
        contentView.addSubview(leftItem)
        contentView.addSubview(rightItem)
        contentView.addSubview(avatar)
        contentView.addSubview(leaderStar)
        contentView.addSubview(name)
        contentView.addSubview(phrase)
        contentView.addSubview(slot1)
        contentView.addSubview(slot2)
        
        setupLabel(label: memberName, text: nil)
        setupLabel(label: memberPhrase, text: nil)
        setupLabel(label: leftItem, text: "Пусто")
        setupLabel(label: rightItem, text: "Пусто")
        setupLabel(label: name, text: "Имя:")
        setupLabel(label: phrase, text: "Фраза:")
        setupLabel(label: slot1, text: "Предмет 1:")
        setupLabel(label: slot2, text: "Предмет 2:")
        
        //Для наглядности
        //TODO сделать через stackView + func
        cardView.snp.makeConstraints { make in
            make.height.equalTo(Constants.cellHeight)
            make.edges.equalTo(contentView).inset(Constants.cardViewInsets)
        }
        avatar.snp.makeConstraints { make in
            make.top.left.equalTo(cardView).inset(Constants.cardViewInsets.left)
            make.bottom.equalTo(cardView).inset(Constants.cardViewInsets.left)
            make.width.equalTo(Constants.deviceWidth / 3)
        }
        leaderStar.snp.makeConstraints { make in
            make.bottom.equalTo(avatar.snp.bottom).inset(Constants.cardViewInsets.top)
            make.left.equalTo(avatar.snp.left).inset(Constants.deviceWidth / 6 - 15)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        name.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.top).inset(Constants.cardViewInsets.top)
            make.left.equalTo(avatar.snp.right).inset(-Constants.cardViewInsets.left)
            make.right.equalTo(cardView.snp.right).inset(Constants.cardViewInsets.right)
            make.height.equalTo(Constants.labelHeight / 2)
        }
        memberName.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).inset(-Constants.cardViewInsets.top / 5)
            make.left.equalTo(avatar.snp.right).inset(-Constants.cardViewInsets.left)
            make.right.equalTo(cardView.snp.right).inset(Constants.cardViewInsets.right)
            make.height.equalTo(Constants.labelHeight / 2)
        }
        phrase.snp.makeConstraints { make in
            make.top.equalTo(memberName.snp.bottom).inset(-Constants.cardViewInsets.top)
            make.left.equalTo(avatar.snp.right).inset(-Constants.cardViewInsets.left)
            make.right.equalTo(cardView.snp.right).inset(Constants.cardViewInsets.right)
            make.height.equalTo(Constants.labelHeight / 2)
        }
        memberPhrase.snp.makeConstraints { make in
            make.top.equalTo(phrase.snp.bottom).inset(-Constants.cardViewInsets.top / 5)
            make.left.equalTo(avatar.snp.right).inset(-Constants.cardViewInsets.left)
            make.right.equalTo(cardView.snp.right).inset(Constants.cardViewInsets.right)
            make.height.equalTo(Constants.labelHeight / 2)
        }
        slot1.snp.makeConstraints { make in
            make.top.equalTo(memberPhrase.snp.bottom).inset(-Constants.cardViewInsets.top)
            make.left.equalTo(avatar.snp.right).inset(-Constants.cardViewInsets.left)
            make.right.equalTo(cardView.snp.right).inset(Constants.cardViewInsets.right)
            make.height.equalTo(Constants.labelHeight / 2)
        }
        leftItem.snp.makeConstraints { make in
            make.top.equalTo(slot1.snp.bottom).inset(-Constants.cardViewInsets.top / 5)
            make.left.equalTo(avatar.snp.right).inset(-Constants.cardViewInsets.left)
            make.right.equalTo(cardView.snp.right).inset(Constants.cardViewInsets.right)
            make.height.equalTo(Constants.labelHeight / 2)
        }
        slot2.snp.makeConstraints { make in
            make.top.equalTo(leftItem.snp.bottom).inset(-Constants.cardViewInsets.top)
            make.left.equalTo(avatar.snp.right).inset(-Constants.cardViewInsets.left)
            make.right.equalTo(cardView.snp.right).inset(Constants.cardViewInsets.right)
            make.height.equalTo(Constants.labelHeight / 2)
        }
        rightItem.snp.makeConstraints { make in
            make.top.equalTo(slot2.snp.bottom).inset(-Constants.cardViewInsets.top / 5)
            make.left.equalTo(avatar.snp.right).inset(-Constants.cardViewInsets.left)
            make.right.equalTo(cardView.snp.right).inset(Constants.cardViewInsets.right)
            make.height.equalTo(Constants.labelHeight / 2)
        }
    }
}
