//
//  AddTeamMember.swift
//  TeamBuilder
//
//  Created by Артем Хребтов on 16.11.2021.
//

import Foundation
import UIKit
import CoreData
import SnapKit


class AddTeamMemberViewController: UIViewController {
    
    var team: Team?
    var member: Member?
    //    var randomMember: RandomMember?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        uiConfiguration()
        teamLabel()
        updateTextFielsds()
    }
    
    func updateTextFielsds() {
        guard let member = member else { return }
        text1.text = member.name
        text2.text = member.phrase
        text3.text = member.leftItem
        text4.text = member.rightItem
        guard let avatarImg = member.avatar else { return }
        avatar.image = UIImage(data: avatarImg)
    }
    func teamLabel() {
        guard let team = team else {
            return
        }
        label.text = team.name
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let text1: UITextField = {
        let text = UITextField()
        text.backgroundColor = .systemBlue
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = .black
        text.placeholder = "name"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    let text2: UITextField = {
        let text = UITextField()
        text.backgroundColor = .systemBlue
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = .black
        text.placeholder = "phrase"
        return text
    }()
    let text3: UITextField = {
        let text = UITextField()
        text.backgroundColor = .systemBlue
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = .black
        text.placeholder = "left item"
        return text
    }()
    let text4: UITextField = {
        let text = UITextField()
        text.backgroundColor = .systemBlue
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = .black
        text.placeholder = "right item"
        return text
    }()
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Save", for: .normal)
        return button
    }()
    let randomButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Random", for: .normal)
        return button
    }()
    
    let avatar: AvatarImage = {
        let image = AvatarImage()
        image.backgroundColor = .yellow
        image.image = UIImage(named: "avatar")
        return image
    }()
    
    //Конфигурируем интерфейс
    func uiConfiguration() {
        
        view.addSubview(text1)
        view.addSubview(text2)
        view.addSubview(text3)
        view.addSubview(text4)
        view.addSubview(button)
        view.addSubview(randomButton)
        view.addSubview(label)
        view.addSubview(avatar)
        
        avatar.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.bottom.equalTo(text1.snp.top).inset(-10)
            make.centerX.equalTo(view)
        }
        label.snp.makeConstraints { make in
            make.bottom.equalTo(view).inset(50)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        text4.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        text3.snp.makeConstraints { make in
            make.bottom.equalTo(text4.snp.top).inset(-10)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        text2.snp.makeConstraints { make in
            make.bottom.equalTo(text3.snp.top).inset(-10)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        text1.snp.makeConstraints { make in
            make.bottom.equalTo(text2.snp.top).inset(-10)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(text4.snp.bottom).inset(-10)
            make.size.equalTo(CGSize(width: 100, height: 30))
            make.centerX.equalTo(view)
        }
        randomButton.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).inset(-10)
            make.size.equalTo(CGSize(width: 100, height: 30))
            make.centerX.equalTo(view)
        }
        
        button.addTarget(self, action: #selector(saveTeamMember), for: .touchUpInside)
        randomButton.addTarget(self, action: #selector(randomTeamMember), for: .touchUpInside)
    }
    
    @objc func randomTeamMember() {
        
        NetworkManager.shared.getRandomPerson { [weak self] data, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.text1.text = data.name
                self?.text2.text = data.phrase
                self?.text3.text = String(data.deathID)
                self?.text4.text = data.avatar
                self?.avatar.set(imgUrl: data.avatar)
            }
        }
    }
    @objc func saveTeamMember() {
        if member == nil {
            guard let name = text1.text else { return }
            guard let phrase = text2.text else { return }
            guard let leftItem = text3.text else { return }
            guard let rightItem = text4.text else { return }
            guard let team = team else { return }
            guard let avatar = avatar.image?.pngData() else { return }
            
            _ = CoreDataManager.shared.teamMember(name: name,
                                                  phrase: phrase,
                                                  leftItem: leftItem,
                                                  rightItem: rightItem,
                                                  team: team,
                                                  avatar: avatar)
            CoreDataManager.shared.save()
            navigationController?.popViewController(animated: true)
        } else {
            member?.name = text1.text
            member?.phrase = text2.text
            member?.leftItem = text3.text
            member?.rightItem = text4.text
            member?.avatar = avatar.image?.pngData()
            
            CoreDataManager.shared.save()
            navigationController?.popViewController(animated: true)
        }
    }
}





