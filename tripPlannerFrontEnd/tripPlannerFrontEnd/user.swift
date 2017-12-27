//
//  user.swift
//  tripPlannerFrontEnd
//
//  Created by Tony Cioara on 12/26/17.
//  Copyright © 2017 Tony Cioara. All rights reserved.
//

import UIKit

struct User: Codable {
    
    let email: String
    var trips: [String]
}

extension User {
    
    enum userKeys: String, CodingKey {
        case email
        case trips
    }
    
    func encode(to encoder: Encoder) throws {
        var value = encoder.container(keyedBy: userKeys.self)
        try value.encode(email, forKey: .email)
        try value.encode(trips, forKey: .trips)
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: userKeys.self)
        let trips = try container.decode([String].self, forKey: .trips)
        let email = try container.decode(String.self, forKey: .email)
        
        self.init(email: email, trips: trips)
    }
    
}
