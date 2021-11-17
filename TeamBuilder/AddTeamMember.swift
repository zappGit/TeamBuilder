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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        uiConfiguration()
        kkk()
        
    }
   
    func kkk() {
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
    //Конфигурируем интерфейс
    func uiConfiguration() {
        
        view.addSubview(text1)
        view.addSubview(text2)
        view.addSubview(text3)
        view.addSubview(text4)
        view.addSubview(button)
        view.addSubview(label)
        
        
        
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
            make.bottom.equalTo(text4.snp.top).inset(-50)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        text2.snp.makeConstraints { make in
            make.bottom.equalTo(text3.snp.top).inset(-50)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        text1.snp.makeConstraints { make in
            make.bottom.equalTo(text2.snp.top).inset(-50)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(text4.snp.bottom).inset(-50)
            make.size.equalTo(CGSize(width: 100, height: 30))
            make.centerX.equalTo(view)
        }
        
        button.addTarget(self, action: #selector(teamName), for: .touchUpInside)
    }
        @objc func teamName() {
            
//            let member = Team(context: self.context)
//            member.name = text1.text
//            member.phrase = text2.text
//            member.leftItem = text3.text
//            member.rightItem = text4.text
//            do {
//                try self.context.save()
//                print("save")
//            }
//            catch {
//
//            }
//            navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    
    
    