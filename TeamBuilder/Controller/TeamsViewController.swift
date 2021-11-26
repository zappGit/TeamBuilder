//
//  TableViewController.swift
//  TeamBuilder
//
//  Created by Артем Хребтов on 14.11.2021.
//

import UIKit
import CoreData

class NavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}

class TeamsViewController: UITableViewController {
    var teams = [Team]()
    var ascendingSorting = true
    var sortImage = UIImage(systemName: "square.and.arrow.down.on.square.fill")
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        teams = CoreDataManager.shared.sorting(ascending: ascendingSorting)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamsViewCell.reuseId, for: indexPath) as! TeamsViewCell
        let teamName = teams[indexPath.row]
        cell.team.text = teamName.name
        return cell
    }
    
    func setupTableView() {
        tableView.register(TeamsViewCell.self, forCellReuseIdentifier: TeamsViewCell.reuseId)
        tableView.separatorStyle = .none
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Список команд"
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addTeam))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: sortImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(sort))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let team = teams[indexPath.row]
        let vc = AddTeamViewController()
        vc.team = team
        navigationController?.pushViewController(vc, animated: true)
    }
    //сортировка команд
    @objc func sort(){
        ascendingSorting.toggle()
        if ascendingSorting {
            navigationItem.leftBarButtonItem?.image = UIImage(systemName: "square.and.arrow.up.on.square.fill")
        } else {
            navigationItem.leftBarButtonItem?.image = UIImage(systemName: "square.and.arrow.down.on.square.fill")
        }
        sorting()
    }
    func sorting() {
        teams = CoreDataManager.shared.sorting(ascending: ascendingSorting)
        tableView.reloadData()
    }
    @objc func addTeam(){
        navigationController?.pushViewController(AddTeamViewController(), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //удаление команды
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let team = teams[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            self.teams.remove(at: indexPath.row)
            CoreDataManager.shared.deleteTeam(team: team)
            CoreDataManager.shared.save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}

