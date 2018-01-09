//
//  Networking.swift
//  tripPlannerFrontEnd
//
//  Created by Tony Cioara on 12/31/17.
//  Copyright © 2017 Tony Cioara. All rights reserved.
//

import Foundation

enum Route {
    
    case post_user(email: String, password: String)
    case get_user
    case patch_user(destination: String, startDate: String, endDate: String, waypoints: String)

    func method() -> String {
        
        switch self {
        case .post_user:
            return "POST"
        case .get_user:
            return "GET"
        case .patch_user:
            return "PATCH"
        //case .delete_user, .delete_trip:
        //    return "DELETE"
        }
    }
    
    
    func path() -> String {
        switch self {
        case .post_user, .get_user, .patch_user:
            return "users"
        }
    }
    
    func body() -> Data? {
        
        switch self {
        case let .post_user(email, password):
            
            let user = PostUser(email: email, password: password, trips: [])
            
            let encoder = JSONEncoder()
            
            let result = try? encoder.encode(user)
            
            return result!
        case let .patch_user(destination, startDate, endDate, waypoints):
            let trip = [destination, startDate, endDate, waypoints]
            
            let encoder = JSONEncoder()
            
            let result = try? encoder.encode(trip)
            
            return result!
        default:
            return nil

        }
    }
        
    func headers(authorization: String) -> [String: String] {
            
        return ["Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": "\(authorization)"]
    }
}
    
    class Network {
        static let instance = Network()
        
        let baseURL = "https://trip-planner-tc.herokuapp.com/"
        let session = URLSession.shared
        
        func fetch(route: Route, token: String, completion: @escaping (Data) -> Void) {
            let fullPath = baseURL + route.path()
            let pathURL = URL(string: fullPath)
            var request = URLRequest(url: pathURL!)
            
            request.httpMethod = route.method()
            request.allHTTPHeaderFields = route.headers(authorization: token)
            var body = route.body()
            
            request.httpBody = route.body()
            
            session.dataTask(with: request) { (data, resp, err) in
//                print(String(describing: data) + String(describing: resp) + String(describing: err))
//                print(String(describing: resp))
                if let data = data {
                    completion(data)
                }
                
                }.resume()
        }
    }

extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        //
        return URL(string: URLString)!
    }
    // This is formatting the query parameters with an ascii table reference therefore we can be returned a json file
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    /**
     This computed property returns a query parameters string from the given NSDictionary. For
     example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
     string will be @"day=Tuesday&month=January".
     @return The computed parameters string.
     */
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}
