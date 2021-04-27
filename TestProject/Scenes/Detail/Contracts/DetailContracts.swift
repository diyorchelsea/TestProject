//
//  DetailContracts.swift
//  TestProject
//
//  Created Diyor Tursunov on 23/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

//MARK: View Events -
/// Detail Module View Events
enum DetailViewEvent {
    case getCar(id: Int)
}

enum DetailFetchEvent {
    case didRecieveCar(object: MainHomeEntity)
}

//MARK: View -
/*
 Should replace "class" with "BaseViewProtocol" if available;
 & that will allow the View to act as a UIViewController;
 & Implement common view functions.
 */
/// Detail Module View Protocol
protocol DetailViewProtocol: UIViewController {
    // Update UI with value returned.
    /// Set the view Object of Type ViewDetailEntity
    func set(object: ViewMainHomeEntity)
    func didReciveCar( by id: ViewMainHomeEntity)
}

//MARK: Interactor -
/// Detail Module Interactor Protocol
protocol DetailInteractorProtocol {
    // Fetch Object from Data Layer
    func fetch(objectFor presenter: DetailPresenterProtocol)
    
    func getCar(by id: Int, for presenter: DetailPresenterProtocol )
}

//MARK: Presenter -
/// Detail Module Presenter Protocol
protocol DetailPresenterProtocol {
    /// The presenter will fetch data from the Interactor thru implementing the Interactor fetch function.
    func fetch(objectFor view: DetailViewProtocol)
    
    /// The presenter will update its state with event
    func update(withEvent event: DetailViewEvent)
    
    /// The Interactor will inform the Presenter a successful fetch.
    func interactor(_ interactor: DetailInteractorProtocol, didFetch event: DetailFetchEvent)
    /// The Interactor will inform the Presenter a failed fetch.
    func interactor(_ interactor: DetailInteractorProtocol, didFailWith error: Error)
}

//MARK: Router (aka: Wireframe) -
/// Detail Module Router Protocol
protocol DetailRouterProtocol {
    // Show Details of Entity Object coming from ParentView Controller.
    // func showDetailsFor(object: DetailEntity, parentViewController viewController: UIViewController)
}
