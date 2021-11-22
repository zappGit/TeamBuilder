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
    var team: Team?
    var members: [Member] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .white
        setupUI()
    }
    //получаем всех членов команды
    override func viewWillAppear(_ animated: Bool) {
        if let allMembers = team?.members?.allObjects as? [Member] {
            members = allMembers
        }
        DispatchQueue.main.async {
            self.navigationItem.title = self.team?.name
            self.tableView.reloadData()
        }
    }
    let addButton = UIButton()
    let saveButton = UIButton()
    //переименование команды
    @objc func rename() {
            teamAlert { text in
                self.team?.name = text
                CoreDataManager.shared.save()
                DispatchQueue.main.async {
                    self.navigationItem.title = self.team?.name
                    self.tableView.reloadData()
                }
            }

    }
    func setupUI() {
        view.addSubview(tableView)
        view.addSubview(addButton)
        view.addSubview(saveButton)
        navigationItem.title = team?.name
        navigationItem.largeTitleDisplayMode = .never
        tableView.register(AddTeamMemberCell.self, forCellReuseIdentifier: AddTeamMemberCell.reuseId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        setupButton(button: addButton, color: .green, text: "Добавить")
        setupButton(button: saveButton, color: .systemBlue, text: "Сохранить")
        addButton.addTarget(self, action: #selector(addMemberToTheTeam), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTeam), for: .touchUpInside)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "pencil"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rename))
        navigationItem.rightBarButtonItem?.isEnabled = team == nil ? false : true 
        // snp
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(addButton.snp.top).inset(-10)
        }
        
        addButton.snp.makeConstraints { make in
            make.left.equalTo(view).inset(Constants.deviceWidth / 4 - Constants.deviceWidth / 10)
            make.bottom.equalTo(view).inset(25)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        saveButton.snp.makeConstraints { make in
            make.right.equalTo(view).inset(Constants.deviceWidth / 4 - Constants.deviceWidth / 10)
            make.bottom.equalTo(view).inset(25)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
    }
    //Алерт создания команды
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
    //Передаем команду на экран добавления/редактирования
    func pathDataToVc() {
        let vc = AddTeamMemberViewController()
        let throwTeam = self.team
        vc.team = throwTeam
        navigationController?.pushViewController(vc, animated: true)
    }
    //добавление члена команды
    @objc func addMemberToTheTeam() {
        if team == nil {
            teamAlert { text in
                self.team = CoreDataManager.shared.team(name: text)
                CoreDataManager.shared.save()
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.pathDataToVc()
            }
        } else {
            pathDataToVc()
        }
    }
    //сохранение команды
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
        cell.leftItem.text = member.leftItem == "" ? "Пусто" : member.leftItem
        cell.rightItem.text = member.rightItem == "" ? "Пусто" : member.rightItem
        guard let avatarImg = member.avatar else { return cell }
        cell.avatar.image = UIImage(data: avatarImg)
        cell.leaderStar.image = member.leader ? UIImage(systemName: "star.fill") : nil
        return cell
    }
    //переход в редактирование
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let member = members[indexPath.row]
        let vc = AddTeamMemberViewController()
        vc.team = team
        vc.member = member
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //удаление
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let member = members[indexPath.row]
        guard !member.leader else {
            errorAlert(message: "Вы не можете удалить лидера")
            return nil
        }
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            self.members.remove(at: indexPath.row)
            CoreDataManager.shared.deleteMember(member: member)
            CoreDataManager.shared.save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}

