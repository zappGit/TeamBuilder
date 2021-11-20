//
//  RandomAPI.swift.swift
//  TeamBuilder
//
//  Created by Артем Хребтов on 20.11.2021.
//

import Foundation
//структура рандомно сгенерированного персонажа через BrakingBad API
struct RandomMember: Codable {
    let deathID: Int
    let name: String
    let phrase: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case deathID = "death_id"
        case name = "death"
        case phrase = "last_words"
        case avatar = "img"
    }
}
