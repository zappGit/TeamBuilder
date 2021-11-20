//
//  NetworkManager.swift
//  TeamBuilder
//
//  Created by Артем Хребтов on 20.11.2021.
//

import Foundation

enum Errors: Error {
    case BadURL
    case BadData
    
    var rawValue: String {
        switch self {
        case .BadURL: return "Не верный URL адрес"
        case .BadData: return "Ошибка получения данных"
        }
    }
}
class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let url = "https://www.breakingbadapi.com/api/random-death"
    
    func getRandomPerson(complition: @escaping(RandomMember?, Error?) -> Void){
        //проверяем правильность ссылки
        guard let urlString = URL(string: url) else {
            complition(nil, Errors.BadURL)
            return
        }
        let task = URLSession.shared.dataTask(with: urlString) { data, response, error in
            if let error = error {
                complition(nil, error)
            }
            
            guard let data = data else {
                complition(nil, Errors.BadData)
                return
            }
            
            do {
                let jsonResult = try JSONDecoder().decode(RandomMember.self, from: data)
                complition(jsonResult, nil)
            } catch let error {
                complition(nil, error)
            }
            
        }
        task.resume()
    }
}
