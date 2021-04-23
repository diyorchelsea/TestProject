//
//  AppDataManager.swift
//  TestProject
//
//  Created by Diyor Tursunov on 22/04/21.
//

//import Foundation
//
//class AppDataManager {
//    
//    private let defaults = UserDefaults.standard
//    
//    private init() {}
//    
//    enum Identifier: String {
//        case apiEnvironment
//    }
//    
//    static let shared = AppDataManager()
//    
//    var apiEnvironment: APIEnvironment {
//        get {
//            let string = defaults.string(forKey: Identifier.apiEnvironment.rawValue) ?? ""
//            return APIEnvironment(rawValue: string) ?? .prod
//        } set {
//            defaults.setValue(newValue.rawValue, forKey: Identifier.apiEnvironment.rawValue)
//        }
//    }
//    
//}
