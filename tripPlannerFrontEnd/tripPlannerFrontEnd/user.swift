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
    var trips: [[String]]
}

struct PostUser: Codable {
    
    let email: String
    let password: String
    var trips: [[String]]
}
