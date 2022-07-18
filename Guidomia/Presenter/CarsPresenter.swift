//
//  CarsPresenter.swift
//  Guidomia
//
//  Created by Rodrigo Velazquez on 16/07/22.
//

import Foundation

protocol CarsPresenterProtocol {
    func sceneDidLoad()
    func sceneWillAppear()
}

final class CarsPresenter {
    var fetchCars: FetchCars
    weak var view: CarsView?
    
    private var cars: [Car] = [] {
        didSet {
            updateView()
        }
    }
    
    init(fetchCars: FetchCars = FetchCarsAdapter(),
         view: CarsView?) {
        self.fetchCars = fetchCars
        self.view = view
    }
}

extension CarsPresenter: CarsPresenterProtocol {
    func sceneDidLoad() {
        requestCars()
    }
    
    func sceneWillAppear() {
    
    }
}

private extension CarsPresenter {
    func updateView() {
        view?.setup(formatViewModel())
    }
    
    func formatViewModel() -> CarsViewModel {
        return .init(headerImage: .init(named: "tacoma"),
                     sections: [cars])
    }
    
    func requestCars() {
        fetchCars.fetch { [weak self] response in
            switch response {
                case .success(let cars):
                    self?.cars = cars
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
            }
        }
    }
}
