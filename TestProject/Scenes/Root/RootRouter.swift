//
//  RootRouter.swift
//  Articles
//
//  Created by Pedro Henrique Prates Peralta on 21/01/17.
//  Copyright © 2017 Pedro Peralta. All rights reserved.
//

import UIKit

protocol AppRouterProtocol: class {
    func showStartPage()
}

class AppRouter: AppRouterProtocol {
    
    private var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    private func setRootView(_ view: UIViewController, animated: Bool = true) {
        window?.rootViewController = view
        window?.makeKeyAndVisible()
        
        guard animated, let window = self.window else { return }
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
        
    }
    
    func showStartPage() {
        let rootView = UINavigationController(rootViewController: MainHomeView())
//        let rootView = NavigationController(rootViewController: NonClientApplicationView())
        self.setRootView(rootView)
    }

}
