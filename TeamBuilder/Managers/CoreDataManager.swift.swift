//
//  CoreDataManager.swift.swift
//  TeamBuilder
//
//  Created by Артем Хребтов on 17.11.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init () {}
    
var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "TeamBuilder")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()
    //Создаем новую команду
    func team(name: String) -> Team {
        let team = Team(context: persistentContainer.viewContext)
        team.name = name
        return team
        
    }
    //создаем члена команды
    func teamMember(name: String, phrase: String, leftItem: String, rightItem: String, team: Team, avatar: Data, leader: Bool) -> Member {
        let member = Member(context: persistentContainer.viewContext)
        member.name = name
        member.phrase = phrase
        member.leftItem = leftItem
        member.rightItem = rightItem
        member.team = team
        member.avatar = avatar
        member.leader = leader
        return member
    }
    //функция для получения всех команд
   func getAllTeams() -> [Team] {
        let request: NSFetchRequest<Team> = Team.fetchRequest()
        var fechedTeams: [Team] = []
        do {
            fechedTeams = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error")
        }
        return fechedTeams
    }
    
    //Сортировка
    func sorting(ascending: Bool) -> [Team] {
        let request: NSFetchRequest<Team> = Team.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: ascending)]
        var fechedTeams: [Team] = []
        do {
            fechedTeams = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error")
        }
        return fechedTeams
    }
    
    func deleteMember(member: Member) {
        persistentContainer.viewContext.delete(member)
    }
    func deleteTeam(team: Team) {
        persistentContainer.viewContext.delete(team)
    }
// MARK: - Core Data Saving support

func save () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
}
