//
//  MainHomeInteractor.swift
//  TestProject
//
//  Created Diyor Tursunov on 22/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// MainHome Module Interactor
class MainHomeInteractor: MainHomeInteractorProtocol {

    // Fetch Object from Data Layer
    func fetch(objectFor presenter: MainHomePresenterProtocol) {
        
    }
    
    func getCars(for presenter: MainHomePresenterProtocol) {
        CarService.getCars { (data) in
            presenter.interactor(self, didFetch: .didRecieveCars(cars: data))
        }
    }

}
