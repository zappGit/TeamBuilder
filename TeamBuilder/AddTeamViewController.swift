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
    let text1: UITextField = {
        let text = UITextField()
        text.backgroundColor = .systemBlue
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = .black
        text.placeholder = "Enter Team name"
        return text
    }()
    let button: UIButton = {
       let button = UIButton()
        button.backgroundColor = .green
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var item: [Team]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(text1)
        view.addSubview(button)
        //        view.addSubview(tableView)
        //        tableView.delegate = self
        //        tableView.dataSource = self
        view.backgroundColor = .red
        
        
        button.addTarget(self, action: #selector(teamName), for: .touchUpInside)
        
        //snp
        //        tableView.snp.makeConstraints { make in
        //            make.edges.equalTo(view)
        text1.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(text1.snp.bottom).inset(-10)
            make.size.equalTo(CGSize(width: 100, height: 30))
            make.centerX.equalTo(view)
        }
    }
    
    func fetchData() {
        do  {
            self.item = try context.fetch(Team.fetchRequest())
        }
        catch {
            
        }
    }
    
    @objc func teamName() {
        let teamName = text1.text
        let newTeamName = Team(context: self.context)
        newTeamName.name = teamName
        do {
            try self.context.save()
            print("save")
        }
        catch {
            
        }
        self.fetchData()
        navigationController?.popViewController(animated: true)
    }
}



//extension AddTeamViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}
