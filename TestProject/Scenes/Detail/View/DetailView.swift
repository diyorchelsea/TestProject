//
//  DetailView.swift
//  TestProject
//
//  Created Diyor Tursunov on 23/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ViewDetailEntity {
    
    private var object : DetailEntity
    
    init(object: DetailEntity) {
        self.object = object
    }
    
}

/// Detail Module View
class DetailView: UIViewController {
    
    private var presenter: DetailPresenterProtocol!
    private var viewObject : ViewDetailEntity?
    
    private lazy var nameLbl = UITextField.create { (field) in
        field.borderStyle = .roundedRect
    }
    
    private lazy var nameFuelValue = UITextField.create { (field) in
        field.borderStyle = .roundedRect
        field.keyboardType = .numberPad
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.presenter = DetailPresenter(view: self)
        
        // Informs the Presenter that the View is ready to receive data.
        self.presenter.fetch(objectFor: self)
        
        self.initUI()
    }
    
    func initUI () {
        self.view.addSubview(nameLbl)
        nameLbl.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        self.view.addSubview(nameFuelValue)
        nameFuelValue.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLbl.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))

    }
    
    
    @objc func saveTapped() {
        
    }
    
}

// MARK: - extending DetailView to implement it's protocol
extension DetailView: DetailViewProtocol {
    func didReciveCar(by id: ViewMainHomeEntity) {
        self.nameLbl.text = id.modelName
        self.nameFuelValue.text = "\(id.fuelConsumptioRate)"
    }
    
    func set(object: ViewMainHomeEntity) {
        self.presenter = DetailPresenter(view: self)
        
        presenter.update(withEvent: .getCar(id: object.id))
    }
    
}
