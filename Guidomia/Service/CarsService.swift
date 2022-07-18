//
//  CarsService.swift
//  Guidomia
//
//  Created by Rodrigo Velazquez on 17/07/22.
//

import Foundation

enum CarsServiceError: Error {
    case fileNotFound
    case parsingError
}

protocol CarsService {
    func fetch(completion: @escaping (Result<[Car], CarsServiceError>) -> Void)
}

final class LocalCarsServiceAdapter {
    
}

extension LocalCarsServiceAdapter: CarsService {
    func fetch(completion: @escaping (Result<[Car], CarsServiceError>) -> Void) {
        guard let path = Bundle.main.path(forResource: "car_list", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            completion(.failure(.fileNotFound))
            return
        }
        
        guard let info = try? JSONDecoder().decode([Car].self, from: data) else {
            completion(.failure(.parsingError))
            return
        }
        
        completion(.success(info))
    }
}
