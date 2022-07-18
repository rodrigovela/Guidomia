//
//  ViewController.swift
//  Guidomia
//
//  Created by Rodrigo Velazquez on 16/07/22.
//

import UIKit

protocol CarsView: AnyObject {
    func setup(_ viewModel: CarsViewModel)
}

struct CarsViewModel {
    static let empty = CarsViewModel()
    
    var headerImage: UIImage?
    var sections: [[Car]] = []
}

final class CarsViewController: UIViewController {

    @IBOutlet weak var headerImage: HeaderImage!
    @IBOutlet private weak var carsTableView: UITableView!
    
    private lazy var presenter: CarsPresenterProtocol = CarsPresenter(view: self)
    var viewModel: CarsViewModel = .empty {
        didSet {
            headerImage.imageView.image = viewModel.headerImage
            headerImage.title.text = "Tacoma 2021"
            headerImage.subtitle.text = "Get your's now"
            carsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter.sceneDidLoad()
        self.view.backgroundColor = .customOrange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension CarsViewController: CarsView {
    func setup(_ viewModel: CarsViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel = viewModel
        }
    }
}

extension CarsViewController: UITableViewDelegate {
    
}

extension CarsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as? CarTableViewCell else {
            return .init()
        }
        return cell
    }
}

private extension CarsViewController {
    func setupTableView() {
        carsTableView.delegate = self
        carsTableView.dataSource = self
        carsTableView.rowHeight = UITableView.automaticDimension
        carsTableView.estimatedRowHeight = UITableView.automaticDimension
        
        let nib = UINib(nibName: "CarTableViewCell", bundle: nil)
        carsTableView.register(nib, forCellReuseIdentifier: "CarTableViewCell")
    }
}
