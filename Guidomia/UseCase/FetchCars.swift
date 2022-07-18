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
    
    init(service: CarsService = LocalCarsServiceAdapter()) {
        self.service = service
    }
}

extension FetchCarsAdapter: FetchCars {
    func fetch(completion: @escaping (Result<[Car], CarsServiceError>) -> Void) {
        service.fetch(completion: completion)
    }
}
