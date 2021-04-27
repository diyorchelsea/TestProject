//
//  CarService.swift
//  TestProject
//
//  Created by Diyor Tursunov on 21/04/21.
//

import Foundation
import Alamofire

class CarService {    
    static func getCars(completion: @escaping ([MainHomeEntity]) -> Void) {
        AF.request(Router.getCarModels).responseData {  (response) in
            switch response.result {
            case .success(let rawJson):
                do {
                    let data = try JSONDecoder().decode([MainHomeEntity].self, from: rawJson)
                    
                    completion(data)
                } catch let err { 
                    print(err)
                }
                
            case .failure(let err):
                    print( err)
            }
        }
    }
    
    static func getCar(by id: Int, completion: @escaping (MainHomeEntity) -> Void) {
        
        AF.request(Router.getCarModel(id: id)).responseData { (response) in
            switch response.result {
            case .success(let rawJson):
                do {
                    let data = try JSONDecoder().decode(MainHomeEntity.self, from: rawJson)
                    
                    completion(data)
                } catch let err {
                    print(err)
                }
            case .failure(let err):
                    print( err)
            }
        }
    }
    
    static func addCar(with data: ViewMainHomeEntity, completion: @escaping (Bool) -> Void) {
        
        AF.request(Router.addCar(model: data)).responseData { (response) in
            switch response.result {
            case .success(let rawJson):
                do {
                    let data = try JSONDecoder().decode(MainHomeEntity.self, from: rawJson)
                    completion(true)
                } catch let err {
                    print(err)
                    completion(false)
                }
            case .failure(let err):
                print( err)
                completion(false)
            }
        }
    }
    
    static func updateCar(with data: ViewMainHomeEntity, completion: @escaping (Bool) -> Void) {
        
        AF.request(Router.update(model: data)).responseData { (response) in
            
            switch response.result {
            case .success(let rawJson):
                print(rawJson)
                completion(true)
            case .failure(let error):
                completion(false)
                print( error)
            }
        }
    }
    
    static func deleteCar(by id: Int, completion: @escaping (Bool) -> Void) {
        AF.request(Router.deleteCarModel(id: id)).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                print(data)
                completion(true)
            case .failure(let err):
            print(err)
                completion(false)
            }
        }
    }
}

