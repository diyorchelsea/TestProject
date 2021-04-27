//
//  MainHomeView.swift
//  TestProject
//
//  Created Diyor Tursunov on 22/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

class ViewMainHomeEntity {
    
    private var object : MainHomeEntity
    
    init(object: MainHomeEntity) {
        self.object = object
    }
    
    var id: Int {
        return object.id ?? 0
    }
    
    var modelName: String {
        return object.modelName ?? ""
    }
    
    var fuelConsumptioRate: Double {
        return object.fuelConsumptioRate ?? 0.0
    }
    
}

/// MainHome Module View
class MainHomeView: BaseViewController {
    
    private lazy var tableView = UITableView.create { (table) in
        table.showsVerticalScrollIndicator = false
    }
    
    private var presenter: MainHomePresenterProtocol!
    private var viewObjects : [ViewMainHomeEntity] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MainHomePresenter(view: self)
        
        view.backgroundColor = .white
        self.presenter.update(withEvent: .getCars)
        self.initUI()
    }
    
    func initUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.tableView.register(UITableViewCell.self)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.update(withEvent: .getCars)
    }
    
    @objc func addTapped() {
        presenter.update(withEvent: .openDetail(item: nil))
    }
    
}

extension MainHomeView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewObjects[indexPath.row]
        
        let cell = tableView.dequeueCell(UITableViewCell.self, indexPath: indexPath)
        cell.textLabel?.text = item.modelName
        cell.detailTextLabel?.text = "\(item.fuelConsumptioRate)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewObjects[indexPath.row]
        presenter.update(withEvent: .openDetail(item: item))
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .default, title: "delete") { (action, index) in
            action.backgroundColor = .red
            let item = self.viewObjects[index.row]
            self.presenter.update(withEvent: .deleteCar(id: item.id))
        }
        return [action]
    }
}

// MARK: - extending MainHomeView to implement it's protocol
extension MainHomeView: MainHomeViewProtocol {
    func updateUI(flag: Bool) {
        if flag {
            self.presenter.update(withEvent: .getCars)
        }
    }
    
    
    // Update UI with value returned.
    /// Set the view Object of ViewMainHomeEntity
    func set(object: [ViewMainHomeEntity]) {
        self.viewObjects = object
        self.tableView.reloadData()
    }
    
}
