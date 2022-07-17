//
//  HeaderImage.swift
//  Guidomia
//
//  Created by Rodrigo Velazquez on 17/07/22.
//

import UIKit

final class HeaderImage: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        imageView.contentMode = .scaleToFill
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        imageView.contentMode = .scaleToFill
    }
    
    func setupView() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        
        self.addSubview(view)
        view.frame = self.bounds
    }
}
