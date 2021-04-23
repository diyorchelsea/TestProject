////
////  BaseApiService.swift
////  TestProject
////
////  Created by Diyor Tursunov on 21/04/21.
////
//
//import Foundation
//import Alamofire
//import AlamofireObjectMapper
//import ObjectMapper
//
//
//class AFSession {
//    static let shared = AFSession()
//    
//    let session: Session = {
////        let trustManager = ServerTrustManager(evaluators: ["dev.infinbank.com": DisabledEvaluator()])
////        let session = Session(configuration: URLSessionConfiguration.af.default, serverTrustManager: trustManager))
//        let session = Session()
//        return session
//    }()
//}
//
//class BaseApiService {
//    
//    private static var refreshingToken: Bool = false
//    private static var refreshTokenCallbacks = [() -> Void]()
//    
//    class func request<T:Mappable>(endpoint: BaseEndPoint,
//                                   completion:@escaping (T, Status, String) -> Void,
//                                   completionError:@escaping (Error?, HTTPURLResponse?) -> Void) {
//        isUnique(endpoint: endpoint, completion: { (ok: Bool) in
//            if ok {
//                BaseApiService.requestApiData(endpoint: endpoint, completion: { (data:ModelResponse<T>) in
//                    if data.status == Status.Ok {
//                        completion(data.data as! T, data.status, data.errorMessage ?? "")
//                    } else {
//                        completion(T(map: Map(mappingType: .fromJSON, JSON: [:]))!,
//                                   data.status ?? Status.Invalid,
//                                   data.errorMessage ?? "")
//                    }
//                }, completionError: completionError)
//            }
//        })
//    }
//    
//    class func cancelRequest(for endpoint: BaseEndPoint) {
//        AFSession.shared.session.session.getAllTasks { (tasks) in
//            let tasks = tasks.filter { (task) -> Bool in
//                let url = String(format: "%@/%@", AppDataManager.shared.apiEnvironment.baseUrl, endpoint.path)
//                let taskUrl = task.originalRequest?.url?.absoluteString ?? ""
//                print("url \(url)\ntaskUrl \(taskUrl)")
//                return url == taskUrl
//            }
//            tasks.forEach({ $0.cancel() })
//        }
//    }
//    
//    class func request<T:Mappable>(endpoint: BaseEndPoint,
//                                   completion:@escaping ([T], Status, String) -> Void,
//                                   completionError:@escaping (Error?, HTTPURLResponse?) -> Void) {
//        isUnique(endpoint: endpoint, completion: { (ok: Bool) in
//            if ok {
//                BaseApiService.requestApiData(endpoint: endpoint, completion: { (data:ModelResponse<T>) in
//                    if (data.status == Status.Ok) {
//                        if let responseData = data.data as? [T] {
//                            completion(responseData, data.status, data.errorMessage ??  "")
//                        } else {
//                            completion([T](), data.status, data.errorMessage ??  "")
//                        }
//                    } else {
//                        completion([T](),
//                                   data.status ?? Status.Ok,
//                                   data.errorMessage ?? "");
//                    }
//                }, completionError: completionError)
//            }
//        })
//    }
//    
//    class func uploadData<T: Mappable>(endpoint: BaseEndPoint,
//                                       data: MultipartFormData,
//                                       completion: @escaping (T, Status, String) -> Void,
//                                       completionError: @escaping (Error?, HTTPURLResponse?) -> Void) {
//        let request = AFSession.shared.session.upload(multipartFormData: data, with: endpoint)
//        
//        request.uploadProgress { (progress) in
//            print("progress \(progress.fractionCompleted)")
//        }
//        
//        request.responseJSON { (response) in
//            BaseApiService.processJsonResponse(endpoint: endpoint, response: response)
//        }
//        
//        request.responseObject { (response: DataResponse<ModelResponse<T>, AFError>) in
//            switch response.result {
//            case .success(let data):
//                if data.status == Status.Ok {
//                    completion(data.data as! T, data.status, data.errorMessage ?? "")
//                } else {
//                    completion(T(map: Map(mappingType: .fromJSON, JSON: [:]))!,
//                               data.status ?? Status.Ok,
//                               data.errorMessage ?? "")
//                }
//            case .failure(let error):
//                completionError(error, response.response)
//            }
//        }
//    }
//    
//    private class func isUnique(endpoint: BaseEndPoint, completion:@escaping (Bool) -> Void) {
////        if !endpoint.path.contains("/unique/") {
////            if let deviceId = AppDataManager.shared.deviceId, deviceId.isEmpty == false {
////                completion(true)
////            } else {
////                let uuid = NSUUID().uuidString.lowercased()
////                APIService.getUniqueDeviceId(id: uuid, completion: { (messages, status, errorMessage) in
////                    if status == Status.Ok {
////                        AppDataManager.shared.deviceId = uuid
////                        completion(true)
////                    }
////                }) { (error, urlResponse) in
////                    completion(false)
////                }
////            }
////        } else {
//            AppDataManager.shared.deviceId = NSUUID().uuidString.lowercased()
//            completion(true)
////        }
//    }
//    
//    private class func requestApiData<T:Mappable>(endpoint: BaseEndPoint,
//                                                  completion:@escaping (ModelResponse<T>) -> Void,
//                                                  completionError:@escaping (Error?, HTTPURLResponse?) -> Void) {
//        
//        AFSession.shared.session.request(endpoint).validate(statusCode: 200..<300).responseJSON(completionHandler: { (response) in
//            BaseApiService.processJsonResponse(endpoint: endpoint, response: response)
//        }).responseObject { (response: DataResponse<ModelResponse<T>, AFError>) in
//            switch response.result {
//            case .success(let data):
//                if data.status == Status.Unauthorized {
//                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    appDelegate.logout()
//                } else if data.status == Status.TokenExpired {
//                    BaseApiService.refreshTokenCallbacks.append {
//                        BaseApiService.requestApiData(endpoint: endpoint,
//                                                      completion: completion,
//                                                      completionError: completionError)
//                    }
//                    BaseApiService.refreshToken()
//                }
//                completion(data)
//            case .failure(let error):
//                completionError(error, response.response)
//                break
//            }
//        }
//        
//    }
//    
//    
//    
//    private class func processJsonResponse(endpoint: BaseEndPoint, response: DataResponse<Any, AFError>) {
//        switch response.result {
//        case .success(let data):
//            print("\n\n===========Success===========")
//            print("URL: \(String(describing: endpoint.urlRequest?.url?.absoluteString ?? ""))")
//            print("Headers: \(endpoint.headers)")
//            print("Status code: \(response.response?.statusCode ?? 0)")
//            print("HTTP Method: \(response.request?.httpMethod ?? "")")
//            print("Parameters: [")
//            endpoint.parameters.forEach { (dict) in
//                print("     \(dict.key): \(dict.value)")
//            }
//            print("]")
//            print("Response: \(data)")
//            print("=============================\n\n")
//        case .failure(let error):
//            print("\n\n===========Error===========")
//            print("URL: \(String(describing: endpoint.urlRequest?.url?.absoluteString))")
//            print("Headers: \(endpoint.headers)")
//            print("Status code: \(String(describing: response.response?.statusCode))")
//            print("HTTP Method: \(response.request?.httpMethod ?? "")")
//            print("Parameters: \(endpoint.parameters)")
//            print("Error Code: \(error._code)")
//            print("Error Messsage: \(error.localizedDescription)")
//            if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8), str != "" {
//                print("Server Error: " + str)
//            }
//            print("===========================\n\n")
//        }
//    }
//    
//    private class func refreshToken() {
//        if self.refreshingToken == true {
//            return
//        }
//        
//        guard let refreshToken = AppDataManager.shared.refreshToken else {
//            return
//        }
//        
//        self.refreshingToken = true
//        AuthAPIService.refreshToken(token: refreshToken,
//                                    completion: { (data, status, errorMessage) in
//                                        if status == .Ok {
//                                            AppDataManager.shared.token = data.token
//                                            AppDataManager.shared.refreshToken = data.refreshToken
//                                            for callback in BaseApiService.refreshTokenCallbacks {
//                                                callback()
//                                            }
//                                            BaseApiService.refreshTokenCallbacks.removeAll()
//                                        } else {
//                                            print("Error message: %@", errorMessage)
//                                        }
//                                        self.refreshingToken = false
//        }) { (error, urlResponse) in
//            self.refreshingToken = false
//            print("Error message: %@", error?.localizedDescription ?? "")
//        }
//        
//    }
//    
//}
