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
    var names = [Team]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
       // fetchPeople()
    }
    
//    func fetchPeople() {
//        do  {
//            self.names = try context.fetch(Team.fetchRequest())
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//        catch {
//
//        }
// }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return names.count
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamsViewCell.reuseId, for: indexPath) as! TeamsViewCell
//        let teamName = names[indexPath.row]
//        cell.teamName.text = teamName.name
        return cell
    }
    
    func setupTableView() {
        tableView.register(TeamsViewCell.self, forCellReuseIdentifier: TeamsViewCell.reuseId)
        tableView.separatorStyle = .none
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Teams list"
        tableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addTeam))
    }
    
    @objc func addTeam(){
//        let rootVc = AddTeamViewController()
//        let navVc = UINavigationController(rootViewController: rootVc)
//        navVc.modalPresentationStyle = .fullScreen
//        present(navVc, animated: true, completion: nil)
        navigationController?.pushViewController(AddTeamViewController(), animated: true)
    }
}

