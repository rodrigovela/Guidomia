//
//  CustomView.swift
//  Guidomia
//
//  Created by Rodrigo Velazquez on 18/07/22.
//

import UIKit

protocol CustomView {
    static var identifier: String { get }
}

extension CustomView where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    func loadXIB() {
        let bundle = Bundle(for: type(of: self))
        guard let view = bundle.loadNibNamed(Self.identifier, owner: self, options: nil)?.first as? UIView else {
            return
        }
        
        addSubview(view)
        view.frame = bounds
    }
}


