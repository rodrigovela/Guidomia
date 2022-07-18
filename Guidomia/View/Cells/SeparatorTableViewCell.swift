//
//  SeparatorTableViewCell.swift
//  Guidomia
//
//  Created by Rodrigo Velazquez on 17/07/22.
//

import UIKit

final class SeparatorTableViewCell: UITableViewCell {

    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

protocol CarsTableViewItem {
    func accept<Visitor: CarsTableViewItemVisitor>(visitor: Visitor, additionalInfo: Visitor.AdditionalInfo) -> Visitor.Result
}

extension CarTableViewCellViewModel: CarsTableViewItem {
    func accept<Visitor>(visitor: Visitor, additionalInfo: Visitor.AdditionalInfo) -> Visitor.Result where Visitor : CarsTableViewItemVisitor {
        return visitor.visit(car: self, additionalInfo: additionalInfo)
    }
}

struct CarTableViewSeparatorViewModel: CarsTableViewItem {
    func accept<Visitor>(visitor: Visitor, additionalInfo: Visitor.AdditionalInfo) -> Visitor.Result where Visitor : CarsTableViewItemVisitor {
        return visitor.visit(separator: self, additionalInfo: additionalInfo)
    }
}

protocol CarsTableViewItemVisitor {
    associatedtype Result
    associatedtype AdditionalInfo
    
    func visit(car: CarTableViewCellViewModel, additionalInfo: AdditionalInfo) -> Result
    func visit(expanded: ExpandedCarTableViewCellViewModel, additionalInfo: AdditionalInfo) -> Result
    func visit(separator: CarTableViewSeparatorViewModel, additionalInfo: AdditionalInfo) -> Result
}
