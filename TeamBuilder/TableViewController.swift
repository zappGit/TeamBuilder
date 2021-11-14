//
//  TableViewController.swift
//  TeamBuilder
//
//  Created by Артем Хребтов on 14.11.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as! TableViewCell
        cell.teamName.text = "Team № \(indexPath.row + 1)"
        return cell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func setupTableView() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseId)
        tableView.separatorStyle = .none
        navigationItem.title = "Teams list"
        tableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addTeam))
    }
    
    @objc func addTeam(){
        print("new team")
    }
}

