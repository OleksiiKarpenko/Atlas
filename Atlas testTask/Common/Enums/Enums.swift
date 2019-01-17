//
//  Enums.swift
//  Atlas testTask
//
//  Created by Oleksii Karpenko on 1/14/19.
//  Copyright © 2019 Oleksii Karpenko. All rights reserved.
//

import Foundation
import Result

//for choose region

enum RegionEnum {
    case europe
    case oceania
    case africa
    case asia
    case americas
    
    var region: String {
        switch  self {
        case .europe:   return "europe"
        case .oceania:  return "oceania"
        case .africa:   return "africa"
        case .asia:     return "asia"
        case .americas: return "americas"
        }
    }
}

// result for responce enum
enum Result<Value> {
    case success(Value)
    case failure(APIError)
}
