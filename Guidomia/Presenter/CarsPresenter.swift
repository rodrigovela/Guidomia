//
//  CarsPresenter.swift
//  Guidomia
//
//  Created by Rodrigo Velazquez on 16/07/22.
//

import UIKit

protocol CarsPresenterProtocol {
    func sceneDidLoad()
    func sceneWillAppear()
}

final class CarsPresenter {
    var fetchCars: FetchCars
    var fetchImage: FetchImage
    weak var view: CarsView?
    
    private var cars: [Car] = [] {
        didSet {
            updateView()
        }
    }
    
    init(fetchCars: FetchCars = FetchCarsAdapter(),
         fetchImage: FetchImage = FetchImageAdapter(),
         view: CarsView?) {
        self.fetchCars = fetchCars
        self.fetchImage = fetchImage
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
        var items: [CarsTableViewItem] = []
        
        cars.enumerated().forEach { element in
            if element.offset != 0 {
                items.append(CarTableViewSeparatorViewModel())
            }
            
            items.append(CarTableViewCellViewModel(image: fetchImage.execute(forModel: element.element),
                                                   title: .init(text: element.element.model,
                                                                appearance: .init(font: .systemFont(ofSize: 20, weight: .bold),
                                                                                  textColor: .customBlack)),
                                                   subtitle: .init(text: "Price: \(Int(element.element.customerPrice / 1000))k",
                                                                   appearance: .init(font: .systemFont(ofSize: 15, weight: .semibold),
                                                                                     textColor: .customBlack)),
                                                   rate: element.element.rating))
            
            
        }
        
        return .init(headerImage: .init(named: "tacoma"),
                     sections: [items])
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
