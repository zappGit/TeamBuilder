//
//  AddTeamViewController.swift
//  TeamBuilder
//
//  Created by Артем Хребтов on 15.11.2021.
//

import Foundation
import UIKit
import SnapKit
import Pods_TeamBuilder


class AddTeamViewController: UIViewController {
    
    let tableView = UITableView()
    var teams: Team?
    var members: [Member] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = #colorLiteral(red: 0.7471456528, green: 0.7610895038, blue: 0.936039567, alpha: 1)
        setupUI()
        navigationItem.title = teams?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let allMembers = teams?.members?.allObjects as? [Member] {
            members = allMembers
        }
        navigationItem.title = teams?.name
        tableView.reloadData()
    }
    func createButton(title: String, backgroundColor: UIColor, textColor: UIColor) -> UIButton {
        let button = UIButton()
        button.backgroundColor = backgroundColor
        button.setTitle("\(title)", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(textColor, for: .normal)
        view.addSubview(button)
        return button
    }
    
    func setupUI() {
        view.addSubview(tableView)
        
        navigationItem.largeTitleDisplayMode = .never
        tableView.register(AddTeamMemberCell.self, forCellReuseIdentifier: AddTeamMemberCell.reuseId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        let addButton = createButton(title: "Add", backgroundColor: .green, textColor: .black)
        let saveButton = createButton(title: "Save", backgroundColor: .blue, textColor: .white)
        let returnButton = createButton(title: "Return", backgroundColor: .red, textColor: .white)
        returnButton.addTarget(self, action: #selector(closeVc), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addMemberToTheTeam), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTeam), for: .touchUpInside)
        // snp
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(addButton.snp.top).inset(-10)
        }
        
        addButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).inset(25)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        saveButton.snp.makeConstraints { make in
            //make.centerX.equalTo(view)
            make.left.equalTo(addButton.snp.right).inset(-25)
            make.bottom.equalTo(view).inset(25)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        returnButton.snp.makeConstraints { make in
            //make.centerX.equalTo(view)
            make.right.equalTo(addButton.snp.left).inset(-25)
            make.bottom.equalTo(view).inset(25)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        tableView.reloadData()
    }
    func errorAlert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func teamAlert(complition: @escaping(String) -> Void ) {
        let alert = UIAlertController(title: "Введите название команды", message: nil, preferredStyle: .alert)
        alert.addTextField { text in
            text.placeholder = "Название команды"
        }
        let okButton = UIAlertAction(title: "Ok", style: .default) { text in
            guard let textField = alert.textFields?.first?.text else { return }
            if textField == ""  {
                self.errorAlert(message: "Название команды не может быть пустым")
                return
            } else {
                complition(textField)
            }
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
        
    }
    
    func pathDataToVc() {
        let vc = AddTeamMemberViewController()
        let throwTeam = self.teams
        vc.team = throwTeam
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addMemberToTheTeam() {
        if teams == nil {
            teamAlert { text in
                self.teams = CoreDataManager.shared.team(name: text)
                CoreDataManager.shared.save()
                //self.tableView.reloadData()
                self.pathDataToVc()
            }
            
        } else {
            pathDataToVc()
        }
        
    }
    @objc func closeVc(){
//        navigationController?.popViewController(animated: true)
    }
    @objc func saveTeam() {
        let membersCount = members.count
        if membersCount < 3 {
            errorAlert(message: "Команда должна состоять минимум из 3х членов. Добавьте еще \(3 - membersCount) персонажа")
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension AddTeamViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddTeamMemberCell.reuseId, for: indexPath) as! AddTeamMemberCell
        let member = members[indexPath.row]
        cell.memberName.text = member.name
        cell.memberPhrase.text = member.phrase
        cell.memberItemLeft.text = member.leftItem
        cell.memberItemRight.text = member.rightItem
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let member = members[indexPath.row]
        let vc = AddTeamMemberViewController()
        vc.team = teams
        vc.member = member
        navigationController?.pushViewController(vc, animated: true)
    }
}

