//
//  LabelViewModel.swift
//  Guidomia
//
//  Created by Rodrigo Velazquez on 17/07/22.
//

import UIKit

struct LabelViewModel {
    struct Appearance {
        var font: UIFont?
        var textColor: UIColor?
    }
    
    var text: String
    var appearance: Appearance
}

extension UILabel {
    func setup(viewModel: LabelViewModel) {
        self.text = viewModel.text
        self.apply(appearance: viewModel.appearance)
    }
    
    private func apply(appearance: LabelViewModel.Appearance) {
        self.font = appearance.font
        
        if let textColor = appearance.textColor {
            self.textColor = textColor
        }
    }
}
