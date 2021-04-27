//
//  MainHomePresenter.swift
//  TestProject
//
//  Created Diyor Tursunov on 22/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// MainHome Module Presenter
class MainHomePresenter {
    
    weak private var view: MainHomeViewProtocol?
    private var interactor: MainHomeInteractorProtocol
    private var wireframe: MainHomeRouterProtocol
    
    init(view: MainHomeViewProtocol) {
        self.view = view
        self.interactor = MainHomeInteractor()
        self.wireframe = MainHomeRouter()
    }
}

// MARK: - extending MainHomePresenter to implement it's protocol
extension MainHomePresenter: MainHomePresenterProtocol {
    
    
    /// The presenter will fetch data from the Interactor thru implementing the Interactor fetch function.
    func fetch(objectFor view: MainHomeViewProtocol) {
        
    }
    
    /// The presenter will update its state with event
    func update(withEvent event: MainHomeViewEvent) {
        switch event {
        case .getCars:
            interactor.getCars(for: self)
        case .deleteCar(let id):
            break
        case .openDetail(let item):
            wireframe.showDetailsFor(item: item ?? nil, parent: self.view!)
        }
    }
    
    /// The Interactor will inform the Presenter a successful fetch.
    func interactor(_ interactor: MainHomeInteractorProtocol, didFetch event: MainHomeFetchEvent) {
        switch event {
        case .didRecieveCars(let cars):
            self.view?.set(object: cars.map{ViewMainHomeEntity(object: $0)})
        }
    }
    
    /// The Interactor will inform the Presenter a failed fetch.
    func interactor(_ interactor: MainHomeInteractorProtocol, didFailWith error: Error) {
        
    }
    
}
