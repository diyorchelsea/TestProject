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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = DetailPresenter(view: self)
        
        // Informs the Presenter that the View is ready to receive data.
        self.presenter.fetch(objectFor: self)
    }
    
}

// MARK: - extending DetailView to implement it's protocol
extension DetailView: DetailViewProtocol {
    
    // Update UI with value returned.
    /// Set the view Object of ViewDetailEntity
    func set(object: ViewDetailEntity) {
        self.viewObject = object
    }
    
}
