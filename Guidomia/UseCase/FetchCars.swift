//
//  FetchCars.swift
//  Guidomia
//
//  Created by Rodrigo Velazquez on 17/07/22.
//

import Foundation

protocol FetchCars {
    func fetch(completion: @escaping (Result<[Car], CarsServiceError>) -> Void)
}

final class FetchCarsAdapter {
    var service: CarsService
    var storage: CarsStorage
    
    init(service: CarsService = LocalCarsServiceAdapter(),
         storage: CarsStorage = CarsStorageAdapter(storage: .standard)) {
        self.service = service
        self.storage = storage
    }
}

extension FetchCarsAdapter: FetchCars {
    func fetch(completion: @escaping (Result<[Car], CarsServiceError>) -> Void) {
        let data = storage.getCars()
        
        guard data.isEmpty else {
            completion(.success(data))
            return
        }
        service.fetch { [weak self] response in
            guard case .success(let cars) = response else {
                completion(response)
                return
            }
            
            self?.storage.save(cars: cars)
            completion(response)
        }
    }
}
