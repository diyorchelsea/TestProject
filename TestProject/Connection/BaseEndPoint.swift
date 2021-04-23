////
////  BaseEndPoint.swift
////  TestProject
////
////  Created by Diyor Tursunov on 21/04/21.
////
//
//
//import UIKit
//import Alamofire
//
//protocol BaseEndPoint: URLRequestConvertible {
//    
//    var path: String { get }
//    
//    var method: HTTPMethod { get }
//    
//    var headers: [String: String] { get }
//    
//    var encoding: ParameterEncoding { get }
//    
//    var parameters: Parameters { get }
//    
//    func asURLRequest() throws -> URLRequest
//    
//}
//
//extension BaseEndPoint {
//    
//    var headers:[String: String] {
//        var headers = ["": ""]
//        
//        
//        return headers
//    }
//    
//    func asURLRequest() throws -> URLRequest {
////        var url = try RouterLite.baseURLString.asURL()
//        var url = try AppDataManager.shared.apiEnvironment.baseUrl.asURL()
////        url = url.appendingPathComponent(RouterLite.api)
////        url = url.appendingPathComponent(RouterLite.version.rawValue)
//        url = url.appendingPathComponent(self.path)
//        
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = self.method.rawValue
//        urlRequest.allHTTPHeaderFields = headers
//        urlRequest.timeoutInterval = 60 // 10 secs
//        urlRequest = try encoding.encode(urlRequest, with: parameters)
//        
//        return urlRequest
//    }
//        
//}
