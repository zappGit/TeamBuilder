//
//  TableViewController.swift
//  TeamBuilder
//
//  Created by Артем Хребтов on 14.11.2021.
//

import UIKit
import CoreData

class TeamsViewController: UITableViewController {
    
    // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var teams = [Team]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        teams = CoreDataManager.shared.getAllTeams()
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        teams = CoreDataManager.shared.getAllTeams()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamsViewCell.reuseId, for: indexPath) as! TeamsViewCell
        let teamName = teams[indexPath.row]
        let members = teamName.members?.allObjects as! [Member]
        cell.teamName.text = teamName.name
        for (id, member) in members.enumerated() {
            if let image = member.avatar {
                cell.imageViewsArray[id].image = UIImage(data: image)
            }
        }
        return cell
    }
    
    func setupTableView() {
        tableView.register(TeamsViewCell.self, forCellReuseIdentifier: TeamsViewCell.reuseId)
        tableView.separatorStyle = .none
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Список команд"
        tableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addTeam))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let team = teams[indexPath.row]
        let vc = AddTeamViewController()
        vc.teams = team
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func addTeam(){
        navigationController?.pushViewController(AddTeamViewController(), animated: true)
    }
}

