//
//  ExpandedCarTableViewCell.swift
//  Guidomia
//
//  Created by Rodrigo Velazquez on 17/07/22.
//

import UIKit

struct ExpandedCarTableViewCellViewModel: CarsTableViewItem {
    var prosTitle: LabelViewModel
    var pros: [LabelViewModel]
    var consTitle: LabelViewModel
    var cons: [LabelViewModel]
    
    func accept<Visitor>(visitor: Visitor, additionalInfo: Visitor.AdditionalInfo) -> Visitor.Result where Visitor : CarsTableViewItemVisitor {
        return visitor.visit(expanded: self, additionalInfo: additionalInfo)
    }
}

final class ExpandedCarTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionStack.arrangedSubviews.forEach(descriptionStack.removeArrangedSubview(_:))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionStack.arrangedSubviews.forEach(descriptionStack.removeArrangedSubview(_:))
        
    }
    
    func setup(viewModel: ExpandedCarTableViewCellViewModel) {
        if !viewModel.pros.isEmpty {
            let title = UILabel()
            title.setup(viewModel: viewModel.prosTitle)
            
            let pros: [UILabel] = viewModel.pros.compactMap { vm in
                let pro = UILabel()
                let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.firstLineHeadIndent = 10.0
                
                
                var bulletAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customOrange,
                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
                bulletAttributes[.paragraphStyle] = paragraphStyle
                let firstString = NSMutableAttributedString(string: "•\t", attributes: bulletAttributes)
                
                firstString.append(NSAttributedString(string: vm.text, attributes: attributes))
                pro.attributedText = firstString
                return pro
            }
            
            descriptionStack.addArrangedSubview(title)
            pros.forEach(descriptionStack.addArrangedSubview(_:))
        }
        
        if !viewModel.cons.isEmpty {
            let title = UILabel()
            title.setup(viewModel: viewModel.consTitle)
            
            let cons: [UILabel] = viewModel.cons.compactMap { vm in
                let con = UILabel()
                let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.firstLineHeadIndent = 10.0
                
                
                var bulletAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customOrange,
                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
                bulletAttributes[.paragraphStyle] = paragraphStyle
                let firstString = NSMutableAttributedString(string: "•\t", attributes: bulletAttributes)
                
                firstString.append(NSAttributedString(string: vm.text, attributes: attributes))
                con.attributedText = firstString
                return con
            }
            
            descriptionStack.addArrangedSubview(title)
            cons.forEach(descriptionStack.addArrangedSubview(_:))
        }
    }
}
