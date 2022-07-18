//
//  FetchImage.swift
//  Guidomia
//
//  Created by Rodrigo Velazquez on 17/07/22.
//

import UIKit

protocol FetchImage {
    func execute(forModel model: Car) -> UIImage?
}

final class FetchImageAdapter: FetchImage {
    func execute(forModel model: Car) -> UIImage? {
        switch model.model {
        case "Range Rover":
            return .init(named: "rangeRover")
        case "Roadster":
            return .init(named: "alpineRoadster")
        case "3300i":
            return .init(named: "bmw330")
        case "GLE coupe":
            return .init(named: "mercedesGLE")
        default:
            return nil
        }
    }
}
