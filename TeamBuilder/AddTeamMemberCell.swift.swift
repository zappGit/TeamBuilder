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
    
    //var member = TeamViewModel.init(members: [])
    
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
    
    var memberName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "member Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var memberPhrase: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "member Phrase"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var memberItemLeft: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "item left"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var memberItemRight: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "item right"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func uiConfiguration() {
        //Добавили кастомный cardView
        contentView.addSubview(cardView)
        contentView.addSubview(memberName)
        contentView.addSubview(memberPhrase)
        contentView.addSubview(memberItemLeft)
        contentView.addSubview(memberItemRight)
        //Добавили название команды
        
        //Закрепили cardView
        cardView.snp.makeConstraints { make in
            make.height.equalTo(Constants.cellHeight)
            make.edges.equalTo(contentView).inset(Constants.cardViewInsets)
        }
        //Закрепили название команды
        memberName.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.top).inset(Constants.cardViewInsets.top)
            make.left.equalTo(cardView.snp.left).inset(Constants.cardViewInsets.left)
            make.right.equalTo(cardView.snp.right).inset(Constants.cardViewInsets.right)
            make.height.equalTo(Constants.labelHeight)
        }
        memberPhrase.snp.makeConstraints { make in
            make.top.equalTo(memberName.snp.bottom).inset(-Constants.cardViewInsets.top)
            make.left.equalTo(cardView.snp.left).inset(Constants.cardViewInsets.left)
            make.right.equalTo(cardView.snp.right).inset(Constants.cardViewInsets.right)
            make.height.equalTo(Constants.labelHeight)
        }
        memberItemLeft.snp.makeConstraints { make in
            make.top.equalTo(memberPhrase.snp.bottom).inset(-Constants.cardViewInsets.top)
            make.left.equalTo(cardView.snp.left).inset(Constants.cardViewInsets.left)
            make.right.equalTo(cardView.snp.right).inset(Constants.cardViewInsets.right)
            make.height.equalTo(Constants.labelHeight)
        }
        memberItemRight.snp.makeConstraints { make in
            make.top.equalTo(memberItemLeft.snp.bottom).inset(-Constants.cardViewInsets.top)
            make.left.equalTo(cardView.snp.left).inset(Constants.cardViewInsets.left)
            make.right.equalTo(cardView.snp.right).inset(Constants.cardViewInsets.right)
            make.height.equalTo(Constants.labelHeight)
        }
    }
    
    func setCell() {
    }
}
