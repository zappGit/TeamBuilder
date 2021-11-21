//
//  TableViewCell.swift
//  TeamBuilder
//
//  Created by Артем Хребтов on 14.11.2021.
//

import UIKit
import SnapKit

class TeamsViewCell: UITableViewCell {
    static let reuseId = "Cell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
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
    let team = UILabel()
    func uiConfiguration() {
        contentView.addSubview(cardView)
        contentView.addSubview(team)
        setupLabel(label: team, text: nil)
        team.font = UIFont.systemFont(ofSize: 20)
        cardView.snp.makeConstraints { make in
            make.height.equalTo(Constants.cellHeight / 3)
            make.edges.equalTo(contentView).inset(Constants.cardViewInsets)
        }
        team.snp.makeConstraints { make in
            make.edges.equalTo(cardView).inset(Constants.cardViewInsets.top)
            make.height.equalTo(Constants.labelHeight)
        }
    }
}
