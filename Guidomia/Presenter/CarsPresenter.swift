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
    func didSelectCar(indexPath: Int)
}

final class CarsPresenter {
    var fetchCars: FetchCars
    var fetchImage: FetchImage
    weak var view: CarsView?
    var expandedItemIndex: Int = 0
    
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
    
    func didSelectCar(indexPath: Int) {
        let deletedIndexPath = expandedItemIndex + 1
        view?.delete(formatViewModel(insert: false), indexPath: [.init(row: deletedIndexPath, section: 0)])
        expandedItemIndex = indexPath
        
        let newViewModel = formatViewModel(insert: true)
        let insertIndex = newViewModel.sections[0].firstIndex { item in
            if let car = item as? CarTableViewCellViewModel {
                return car.index == indexPath
            } else {
                return false
            }
        } ?? 0
        view?.insert(formatViewModel(insert: true), indexPath: [.init(row: insertIndex + 1, section: 0)])
    }
}

private extension CarsPresenter {
    func updateView() {
        view?.setup(formatViewModel())
    }
    
    func formatViewModel(insert: Bool = true) -> CarsViewModel {
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
                                                   rate: element.element.rating,
                                                   index: element.offset))
            
            if expandedItemIndex == element.offset && insert {
                items.append(ExpandedCarTableViewCellViewModel(prosTitle: .init(text: "Pros",
                                                                                appearance: .init(font: .systemFont(ofSize: 15, weight: .semibold),
                                                                                                  textColor: .customBlack)),
                                                               pros: element.element.prosList.compactMap { pro in
                                                                guard !pro.isEmpty else { return nil }
                                                                return .init(text: pro,
                                                                             appearance: .init(font: .systemFont(ofSize: 14,
                                                                                                                 weight: .semibold),
                                                                                               textColor: .black))
                                                               },
                                                               consTitle: .init(text: "Cons",
                                                                                appearance: .init(font: .systemFont(ofSize: 15,
                                                                                                                    weight: .semibold),
                                                                                                                textColor: .customBlack)),
                                                               cons: element.element.consList.compactMap { con in
                                                                guard !con.isEmpty else { return nil }
                                                                return .init(text: con,
                                                                             appearance: .init(font: .systemFont(ofSize: 14,
                                                                                                                 weight: .semibold),
                                                                                               textColor: .black))
                                                               }))
            }
            
            
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
