//
//  URL.swift
//  infinBank2
//
//  Created by typedef on 6/3/20.
//  Copyright © 2020 InfinBank. All rights reserved.
//

import Foundation


extension URL {
    
    func appending(_ queryItem: String, value: String?) -> URL {
        
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        
        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        
        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)
        
        // Append the new query item in the existing query items array
        queryItems.append(queryItem)
        
        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems
        
        // Returns the url from new url components
        return urlComponents.url!
    }
    
    func appending(items:[String:Any]) -> URL {
        
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        
        if var queryItems =  urlComponents.queryItems {
            // Create query item
            for (key, value) in items {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                queryItems.append(queryItem)
            }
            
            // Append updated query items array in the url component object
            urlComponents.queryItems = queryItems
        }
        
        // Returns the url from new url components
        return urlComponents.url!
        
    }
}

public enum Status : Int, Decodable {
    case Ok = 0
    case serverError = 9
}
