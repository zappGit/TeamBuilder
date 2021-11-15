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
        selectionStyle = .none
        
        //Инициалицируем команду
        for i in 0 ... Constants.teamCapasity - 1 {
            let imageView = UIImageView()
            imageViewsArray.append(imageView)
            setupImageViews(imageView: imageViewsArray[i])
        }
       
        uiConfiguration()
        imageViewsArray[0].image = UIImage(systemName: "photo")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    let teamName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Team Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func makeTeamMember() -> UIImageView {
        let image = UIImageView()
        image.backgroundColor = .green
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
    
    func setupImageViews(imageView: UIImageView) {
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }

    var imageViewsArray = [UIImageView]()
    
    let crownIcon: UIImageView = {
       let image = UIImageView()
        image.image = UIImage.init(systemName: "crown")
        image.tintColor = .yellow
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func uiConfiguration() {
        //Добавили кастомный cardView
        contentView.addSubview(cardView)
        //Добавили название команды
        contentView.addSubview(teamName)
        //Добавили все ImageView
        for i in 0 ... imageViewsArray.count - 1 {
            contentView.addSubview(imageViewsArray[i])
        }
        // Добавили метку лидера
        contentView.addSubview(crownIcon)
        //Закрепили cardView
        cardView.snp.makeConstraints { make in
            make.height.equalTo(Constants.cellHeight)
            make.edges.equalTo(contentView).inset(Constants.cardViewInsets)
        }
        //Закрепили название команды
        teamName.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.top).inset(Constants.cardViewInsets.top)
            make.left.equalTo(cardView.snp.left).inset(Constants.cardViewInsets.left)
            make.right.equalTo(cardView.snp.right).inset(Constants.cardViewInsets.right)
            make.height.equalTo(Constants.labelHeight)
        }
        //Закрепление ImageView членов команды
        for member in 0 ... imageViewsArray.count - 1 {
            imageViewsArray[member].snp.makeConstraints { make in
                make.bottom.equalTo(cardView.snp.bottom).inset(Constants.cardViewInsets.top)
                make.size.equalTo(Constants.leaderImageSize)
                if member == 0 {
                    make.left.equalTo(cardView.snp.left).inset(Constants.cardViewInsets.left)
                } else {
                    make.left.equalTo(imageViewsArray[member - 1].snp.right).inset(-Constants.cardViewInsets.left)
                }
            }
            
        }
        let leaderPosition = 2
        //Закрепление метки лидера
        crownIcon.snp.makeConstraints { make in
            make.bottom.equalTo(imageViewsArray[leaderPosition].snp.top).inset(-Constants.cardViewInsets.top / 2)
            make.top.equalTo(teamName.snp.bottom).inset(-Constants.cardViewInsets.top / 2)
            make.left.equalTo(imageViewsArray[leaderPosition].snp.left).inset(Constants.leaderImageSize.width / 2 - Constants.crownSize.width / 2)
            make.size.equalTo(Constants.crownSize)
        }
    }
}
