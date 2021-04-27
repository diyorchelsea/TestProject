//
//  Router.swift
//  TestProject
//
//  Created by Diyor Tursunov on 21/04/21.
//

import Foundation
import Alamofire
import ObjectMapper

enum Router: URLRequestConvertible {

    private var basePath: String {
        return "https://gwstage.ttonline.ru/testbackend/test7/hs/Gateway/"
    }
    
    case getCarModels
    case getCarModel(id: Int)
    case addCar(model: ViewMainHomeEntity)
    case update(model: ViewMainHomeEntity)
    case deleteCarModel(id: Int)


    private var path: String {
        switch self {
        case .getCarModels:
            return "carModels"
        case .getCarModel(let id):
            return "carModels/\(id)"
        case .addCar:
            return "carModels"
        case .update(let model):
            return "carModels/\(model.id)"
        case .deleteCarModel(let id):
            return "carModels/\(id)"
        }
    }

    private var method: HTTPMethod {
        switch self {
        case .getCarModels:
            return .get
        case .getCarModel:
            return .get
        case .addCar:
            return .post
        case .update:
            return .put
        case .deleteCarModel:
            return .delete
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case .getCarModels:
            return [:]
        case .getCarModel(let id):
            return ["id": id]
        case .addCar (let model):
            return ["id": model.id,
                    "modelName": model.modelName,
                    "fuelConsumptioRate": model.fuelConsumptioRate]
        case .update(let model):
            return ["modelName": model.modelName,
                    "fuelConsumptioRate": model.fuelConsumptioRate]
        case .deleteCarModel(let id):
            return ["id": id]
        }
    }
    
    var headers:[String: String] {
        let user = "TestUser"
        let password = "sdcJUhz8Wj9i"

        let credentialData = "\(user):\(password)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!

        let base64Credentials = credentialData.base64EncodedString()


           let headers = [
                    "Authorization": "Basic \(base64Credentials)",
                    "Accept": "application/json",
                    "Content-Type": "application/json" ]
        
        
        return headers
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getCarModels:
            return  URLEncoding.default
        case .addCar:
            return JSONEncoding.default
        case .update:
            return JSONEncoding.default
        case .deleteCarModel:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
        
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = try basePath.asURL()
        url = url.appendingPathComponent(self.path)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.timeoutInterval = 60 // 10 secs
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        
        return urlRequest
    }

}
