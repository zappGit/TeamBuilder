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

class AddTeamMemberViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var team: Team?
    var member: Member?
    var members: [Member?] = []
    private var status = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        setupAvatar()
        uiConfiguration()
        updateTextFielsds()
        hideKeyWhenTap()
        getAllMembers()
    }
    
    func setupAvatar(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar))
        tap.numberOfTouchesRequired = 1
        avatar.isUserInteractionEnabled = true
        avatar.addGestureRecognizer(tap)
    }
    @objc func didTapAvatar(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let photo = UIAlertAction(title: "Галерея", style: .default){ _ in
            self.imagePicker(sourse: .photoLibrary)
        }
        let camera = UIAlertAction(title: "Камера", style: .default){ _ in
            self.imagePicker(sourse: .camera)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(photo)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    //Image Picker sourse type
    func imagePicker(sourse: UIImagePickerController.SourceType) {
        //Если есть такой тип источника для пикера
        if UIImagePickerController.isSourceTypeAvailable(sourse) {
            //Создаем пикер, разрешаем редактировать, присваиваем источник
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourse
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        avatar.image = (info[.editedImage] as! UIImage)
        avatar.contentMode = .scaleToFill
        avatar.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    
    func getAllMembers() {
        if let allMembers = team?.members?.allObjects as? [Member] {
            members = allMembers
        }
    }
    //Заполняем поля члена команды в окне редактирования
    func updateTextFielsds() {
        guard let member = member else { return }
        saveButton.setTitle("Внести изменения", for: .normal)
        nameTextField.text = member.name
        phraseTextField.text = member.phrase
        leftItemTextField.text = member.leftItem
        rightItemTextField.text = member.rightItem
        leaderStatusLabel.text = member.leader ? "Лидер команды" : "Рядовой член команды"
        guard let avatarImg = member.avatar else { return }
        avatar.image = UIImage(data: avatarImg)
    }
    //Создаем элементы интерфейса
    let avatar: AvatarImage = {
        let image = AvatarImage()
        image.backgroundColor = .yellow
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "avatar")
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let leaderLabel = UILabel()
    let leaderStatusLabel = UILabel()
    let phraseLabel = UILabel()
    let phraseTextField = UITextField()
    let leftItemLabel = UILabel()
    let leftItemTextField = UITextField()
    let rightItemLabel = UILabel()
    let rightItemTextField = UITextField()
    let saveButton = UIButton()
    let randomButton = UIButton()
    let leaderButton = UIButton()
    //Конфигурируем интерфейс
    func uiConfiguration() {
        view.addSubview(saveButton)
        view.addSubview(leaderLabel)
        view.addSubview(leaderStatusLabel)
        view.addSubview(randomButton)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(phraseLabel)
        view.addSubview(phraseTextField)
        view.addSubview(leftItemLabel)
        view.addSubview(leftItemTextField)
        view.addSubview(rightItemLabel)
        view.addSubview(rightItemTextField)
        view.addSubview(avatar)
        view.addSubview(leaderButton)
        setupLabel(label: nameLabel, text: "Имя")
        setupLabel(label: phraseLabel, text: "Фраза")
        setupLabel(label: leftItemLabel, text: "Предмет 1")
        setupLabel(label: rightItemLabel, text: "Предмет 2")
        setupLabel(label: leaderLabel, text: "Статус")
        setupLabel(label: leaderStatusLabel, text: "Рядовой член команды")
        setupTextField(textField: nameTextField, placeholder: "Введите имя")
        setupTextField(textField: phraseTextField, placeholder: "Введите коронную фразу")
        setupTextField(textField: leftItemTextField, placeholder: "Предмет слот 1")
        setupTextField(textField: rightItemTextField, placeholder: "Предмет слот 2")
        setupButton(button: saveButton, color: .green, text: "Добавить в команду")
        setupButton(button: randomButton, color: .systemBlue, text: "Случайный персонаж")
        setupButton(button: leaderButton, color: .yellow, text: "Назначить лидером")
    
        
        //Устанавливаем зависимости
        avatar.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: Constants.deviceWidth / 2, height: Constants.deviceWidth / 2))
            make.top.equalTo(view).inset(Constants.cardViewInsets.top * 10)
            make.centerX.equalTo(view)
        }
        leaderLabel.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).inset(-10)
            make.left.equalTo(view.snp.left).inset(Constants.cardViewInsets.left)
            make.size.equalTo(CGSize(width: Constants.deviceWidth / 4, height: Constants.labelHeight))
        }
        leaderStatusLabel.snp.makeConstraints { make in
            make.left.equalTo(leaderLabel.snp.right).inset(-Constants.cardViewInsets.left)
            make.right.equalTo(view.snp.right).inset(Constants.cardViewInsets.right)
            make.top.equalTo(avatar.snp.bottom).inset(-10)
            make.height.equalTo(CGFloat(Constants.labelHeight))
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(leaderLabel.snp.bottom).inset(-10)
            make.left.equalTo(view.snp.left).inset(Constants.cardViewInsets.left)
            make.size.equalTo(CGSize(width: Constants.deviceWidth / 4, height: Constants.labelHeight))
        }
        nameTextField.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right).inset(-Constants.cardViewInsets.left)
            make.right.equalTo(view.snp.right).inset(Constants.cardViewInsets.right)
            make.top.equalTo(leaderStatusLabel.snp.bottom).inset(-10)
            make.height.equalTo(CGFloat(Constants.labelHeight))
        }
        phraseLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-10)
            make.left.equalTo(view.snp.left).inset(Constants.cardViewInsets.left)
            make.size.equalTo(CGSize(width: Constants.deviceWidth / 4, height: Constants.labelHeight))
        }
        phraseTextField.snp.makeConstraints { make in
            make.left.equalTo(phraseLabel.snp.right).inset(-Constants.cardViewInsets.left)
            make.right.equalTo(view.snp.right).inset(Constants.cardViewInsets.right)
            make.top.equalTo(nameTextField.snp.bottom).inset(-10)
            make.height.equalTo(CGFloat(Constants.labelHeight))
        }
        leftItemLabel.snp.makeConstraints { make in
            make.top.equalTo(phraseLabel.snp.bottom).inset(-10)
            make.left.equalTo(view.snp.left).inset(Constants.cardViewInsets.left)
            make.size.equalTo(CGSize(width: Constants.deviceWidth / 4, height: Constants.labelHeight))
        }
        leftItemTextField.snp.makeConstraints { make in
            make.left.equalTo(leftItemLabel.snp.right).inset(-Constants.cardViewInsets.left)
            make.right.equalTo(view.snp.right).inset(Constants.cardViewInsets.right)
            make.top.equalTo(phraseTextField.snp.bottom).inset(-10)
            make.height.equalTo(CGFloat(Constants.labelHeight))
        }
        rightItemLabel.snp.makeConstraints { make in
            make.top.equalTo(leftItemLabel.snp.bottom).inset(-10)
            make.left.equalTo(view.snp.left).inset(Constants.cardViewInsets.left)
            make.size.equalTo(CGSize(width: Constants.deviceWidth / 4, height: Constants.labelHeight))
        }
        rightItemTextField.snp.makeConstraints { make in
            make.left.equalTo(rightItemLabel.snp.right).inset(-Constants.cardViewInsets.left)
            make.right.equalTo(view.snp.right).inset(Constants.cardViewInsets.right)
            make.top.equalTo(leftItemTextField.snp.bottom).inset(-10)
            make.height.equalTo(CGFloat(Constants.labelHeight))
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(leaderButton.snp.bottom).inset(-10)
            make.size.equalTo(CGSize(width: Constants.deviceWidth / 2, height: Constants.labelHeight))
            make.centerX.equalTo(view)
        }
        randomButton.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).inset(-10)
            make.size.equalTo(CGSize(width: Constants.deviceWidth / 2, height: Constants.labelHeight))
            make.centerX.equalTo(view)
        }
        leaderButton.snp.makeConstraints { make in
            make.top.equalTo(rightItemTextField.snp.bottom).inset(-10)
            make.size.equalTo(CGSize(width: Constants.deviceWidth / 2, height: Constants.labelHeight))
            make.centerX.equalTo(view)
        }
        saveButton.addTarget(self, action: #selector(saveTeamMember), for: .touchUpInside)
        randomButton.addTarget(self, action: #selector(randomTeamMember), for: .touchUpInside)
        leaderButton.addTarget(self, action: #selector(giveLeaderStatus), for: .touchUpInside)
    }
    @objc func giveLeaderStatus(){
        for member in members {
            member?.leader = false
        }
        leaderStatusLabel.text = "Лидер команды"
        status = true
    }
    @objc func randomTeamMember() {
        //Сетевой запрос получения случайного персонажа
        NetworkManager.shared.getRandomPerson { [weak self] data, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.nameTextField.text = data.name
                self?.phraseTextField.text = data.phrase
                self?.avatar.set(imgUrl: data.avatar)
                self?.saveButton.isEnabled = true
                self?.saveButton.backgroundColor = .green
            }
        }
    }
    //Сохраняем персонажа в CoreData
    @objc func saveTeamMember() {
        guard nameTextField.text?.isEmpty == false, phraseTextField.text?.isEmpty == false else {
            errorAlert(message: "Поля имя и фраза должны быть заполнены для сохранения персонажа")
            return
        }
        if member == nil {
            guard let name = nameTextField.text else { return }
            guard let phrase = phraseTextField.text else { return }
            guard let leftItem = leftItemTextField.text else { return }
            guard let rightItem = rightItemTextField.text else { return }
            guard let team = team else { return }
            guard let avatar = avatar.image?.pngData() else { return }
            if members.isEmpty && !status {
                errorAlert(message: "Команда не может создаваться без лидера. Назначте лидера")
            } else {
            _ = CoreDataManager.shared.teamMember(name: name,
                                                  phrase: phrase,
                                                  leftItem: leftItem,
                                                  rightItem: rightItem,
                                                  team: team,
                                                  avatar: avatar,
                                                  leader: status)
            CoreDataManager.shared.save()
            navigationController?.popViewController(animated: true)
            }
        } else {
            member?.name = nameTextField.text
            member?.phrase = phraseTextField.text
            member?.leftItem = leftItemTextField.text
            member?.rightItem = rightItemTextField.text
            member?.avatar = avatar.image?.pngData()
            member?.leader = status
            
            CoreDataManager.shared.save()
            navigationController?.popViewController(animated: true)
        }
    }
}






