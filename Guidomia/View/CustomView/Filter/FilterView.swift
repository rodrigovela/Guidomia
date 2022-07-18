//
//  FilterView.swift
//  Guidomia
//
//  Created by Rodrigo Velazquez on 17/07/22.
//

import UIKit

struct FilterViewModel {
    var title: LabelViewModel
    var anyMakeOptions: [String]
    var anyModelOptions: [String]
}

final class FilterView: UIView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var anyMakeDropdown: UITextField!
    private lazy var anyMakePicker = UIPickerView()
    @IBOutlet weak var anyModelDropdown: UITextField!
    private lazy var anyModelPicker = UIPickerView()
    private var anyMakeOptions: [String] = []
    private var anyModelOptions: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    func setupDropDown() {
        anyMakeDropdown.inputView = anyMakePicker
        anyModelDropdown.inputView = anyModelPicker
    }
    
    func setup(viewModel: FilterViewModel) {
        self.title.setup(viewModel: viewModel.title)
    }
}

extension FilterView: UIPickerViewDelegate {

}

extension FilterView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === anyMakePicker {
            return anyMakeOptions.count
        } else if pickerView === anyModelPicker {
            return anyModelOptions.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView === anyMakePicker {
            return anyMakeOptions[row]
        } else if pickerView === anyModelPicker {
            return anyModelOptions[row]
        } else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView === anyMakePicker {
            anyMakeDropdown.text = anyMakeOptions[row]
        } else if pickerView === anyModelPicker {
            anyModelDropdown.text = anyModelOptions[row]
        }
    }
}
