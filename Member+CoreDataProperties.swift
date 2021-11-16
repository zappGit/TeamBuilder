//
//  Member+CoreDataProperties.swift
//  TeamBuilder
//
//  Created by Артем Хребтов on 16.11.2021.
//
//

import Foundation
import CoreData


extension Member {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Member> {
        return NSFetchRequest<Member>(entityName: "Member")
    }

    @NSManaged public var name: String?
    @NSManaged public var phrase: String?
    @NSManaged public var leftItem: String?
    @NSManaged public var rightItem: String?
    @NSManaged public var team: Team?

}

extension Member : Identifiable {

}
