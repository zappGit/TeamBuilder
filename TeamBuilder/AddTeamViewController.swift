//
//  AddTeamViewController.swift
//  TeamBuilder
//
//  Created by Артем Хребтов on 15.11.2021.
//

import Foundation
import UIKit
import SnapKit
import CoreData

class AddTeamViewController: UIViewController {
    
    let tableView = UITableView()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var item: [Team]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = #colorLiteral(red: 0.7471456528, green: 0.7610895038, blue: 0.936039567, alpha: 1)
        fetchData()
        setupUI()
    }
    
    func fetchData() {
        do  {
            self.item = try context.fetch(Team.fetchRequest())
        }
        catch {

        }
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
    }
    @objc func addMemberToTheTeam() {
        navigationController?.pushViewController(AddTeamMemberViewController(), animated: true)
    }
    @objc func closeVc(){
        navigationController?.popViewController(animated: true)
    }
//    @objc func teamName() {
//        let teamName = text1.text
//        let newTeamName = Team(context: self.context)
//        newTeamName.name = teamName
//        do {
//            try self.context.save()
//            print("save")
//        }
//        catch {
//
//        }
//        self.fetchData()
//        navigationController?.popViewController(animated: true)
//    }
}



extension AddTeamViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddTeamMemberCell.reuseId, for: indexPath) as! AddTeamMemberCell
        return cell
    }
}
