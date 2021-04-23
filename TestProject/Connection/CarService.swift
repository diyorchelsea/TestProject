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
        
        AF.request(Router.getCarModel(id: id)).responseJSON { (response) in
            switch response.result {
            case .success(let rawJson):

                print(rawJson)
            case .failure(let err):
                    print( err)
            }
        }
    }

}

