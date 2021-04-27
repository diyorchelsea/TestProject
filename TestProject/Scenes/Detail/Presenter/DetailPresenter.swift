//
//  DetailPresenter.swift
//  TestProject
//
//  Created Diyor Tursunov on 23/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// Detail Module Presenter
class DetailPresenter {
    
    weak private var view: DetailViewProtocol?
    private var interactor: DetailInteractorProtocol
    private var wireframe: DetailRouterProtocol
    
    init(view: DetailViewProtocol) {
        self.view = view
        self.interactor = DetailInteractor()
        self.wireframe = DetailRouter()
    }
}

// MARK: - extending DetailPresenter to implement it's protocol
extension DetailPresenter: DetailPresenterProtocol {
    
    
    /// The presenter will fetch data from the Interactor thru implementing the Interactor fetch function.
    func fetch(objectFor view: DetailViewProtocol) {
        
    }
    
    /// The presenter will update its state with event
    func update(withEvent event: DetailViewEvent) {
        switch event {
        case .getCar(let id):
            interactor.getCar(by: id, for: self)
        }
    }
    
    /// The Interactor will inform the Presenter a successful fetch.
    func interactor(_ interactor: DetailInteractorProtocol, didFetch event: DetailFetchEvent) {
        switch event {
        case .didRecieveCar(let object):
            self.view?.didReciveCar(by: ViewMainHomeEntity(object: object))
         }
    }
    
    /// The Interactor will inform the Presenter a failed fetch.
    func interactor(_ interactor: DetailInteractorProtocol, didFailWith error: Error) {
        
    }
    
}
