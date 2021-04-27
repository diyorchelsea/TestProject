//
//  DetailInteractor.swift
//  TestProject
//
//  Created Diyor Tursunov on 23/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// Detail Module Interactor
class DetailInteractor: DetailInteractorProtocol {
    
    // Fetch Object from Data Layer
    func fetch(objectFor presenter: DetailPresenterProtocol) {
        
    }
    
    func getCar(by id: Int, for presenter: DetailPresenterProtocol) {
        CarService.getCar(by: id) { (res) in
            presenter.interactor(self, didFetch: .didRecieveCar(object: res))
        }
    }
    
    func update(with object: ViewMainHomeEntity, for presenter: DetailPresenterProtocol) {
        CarService.updateCar(with: object) { (res) in
            presenter.interactor(self, didFetch: .didUpdateCar(result: res))
        }
    }
    
    func addCar(with object: ViewMainHomeEntity, for presenter: DetailPresenterProtocol) {
        CarService.addCar(with: object) { (res) in
            presenter.interactor(self, didFetch: .didAddCar(result: res))
        }
    }
    
}
