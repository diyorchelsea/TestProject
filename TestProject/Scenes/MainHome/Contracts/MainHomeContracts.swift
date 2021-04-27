//
//  MainHomeContracts.swift
//  TestProject
//
//  Created Diyor Tursunov on 22/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

//MARK: View Events -
/// MainHome Module View Events
enum MainHomeViewEvent {
    case getCars
    case deleteCar(id: Int)
    case openDetail(item: ViewMainHomeEntity?)
//    case getCar(id: Int)
}

enum MainHomeFetchEvent {
    case didRecieveCars(cars: [MainHomeEntity])
    case didDeleteCar(result: Bool)
}

//MARK: View -
/*
 Should replace "class" with "BaseViewProtocol" if available;
 & that will allow the View to act as a UIViewController;
 & Implement common view functions.
 */
/// MainHome Module View Protocol
protocol MainHomeViewProtocol: UIViewController {
    // Update UI with value returned.
    /// Set the view Object of Type ViewMainHomeEntity
    func set(object: [ViewMainHomeEntity])
    func updateUI(flag: Bool)
}

//MARK: Interactor -
/// MainHome Module Interactor Protocol
protocol MainHomeInteractorProtocol {
    // Fetch Object from Data Layer
    func fetch(objectFor presenter: MainHomePresenterProtocol)
    
    func getCars(for presenter: MainHomePresenterProtocol)
    
    func deletaCar(id: Int, for presenter: MainHomePresenterProtocol )
}

//MARK: Presenter -
/// MainHome Module Presenter Protocol
protocol MainHomePresenterProtocol {
    /// The presenter will fetch data from the Interactor thru implementing the Interactor fetch function.
    func fetch(objectFor view: MainHomeViewProtocol)
    
    /// The presenter will update its state with event
    func update(withEvent event: MainHomeViewEvent)
    
    /// The Interactor will inform the Presenter a successful fetch.
    func interactor(_ interactor: MainHomeInteractorProtocol, didFetch event: MainHomeFetchEvent)
    
    /// The Interactor will inform the Presenter a failed fetch.
    func interactor(_ interactor: MainHomeInteractorProtocol, didFailWith error: Error)
}

//MARK: Router (aka: Wireframe) -
/// MainHome Module Router Protocol
protocol MainHomeRouterProtocol: class {
    // Show Details of Entity Object coming from ParentView Controller.
     func showDetailsFor(item: ViewMainHomeEntity?, parent: UIViewController)

    
}
