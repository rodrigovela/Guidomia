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
    weak var view: CarsView?
    
    init(view: CarsView?) {
        self.view = view
    }
}

extension CarsPresenter: CarsPresenterProtocol {
    func sceneDidLoad() {
        view?.setup(formatViewModel())
    }
    
    func sceneWillAppear() {
    
    }
}

private extension CarsPresenter {
    func formatViewModel() -> CarsViewModel {
        return .init(headerImage: .init(named: "tacoma"),
                     sections: [])
    }
}
