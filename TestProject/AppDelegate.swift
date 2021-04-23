//
//  AppDelegate.swift
//  TestProject
//
//  Created by Diyor Tursunov on 21/04/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private(set) var router: AppRouterProtocol?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        self.router = AppRouter(window: self.window)
        self.router?.showStartPage()
        
        return true
    }




}

