//
//  Auth Helpers.swift
//  tripPlannerFrontEnd
//
//  Created by Tony Cioara on 12/31/17.
//  Copyright © 2017 Tony Cioara. All rights reserved.
//

import Foundation

struct BasicAuth {
    static func generateBasicAuthHeader(username: String, password: String) -> String {
        let loginString = String(format: "%@:%@", username, password)
        let loginData: Data = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString(options: .init(rawValue: 0))
        let authHeaderString = "Basic \(base64LoginString)"
        
        return authHeaderString
    }
}
