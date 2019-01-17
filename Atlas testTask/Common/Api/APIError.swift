//
//  ApiError.swift
//  Atlas testTask
//
//  Created by Oleksii Karpenko on 1/17/19.
//  Copyright © 2019 Oleksii Karpenko. All rights reserved.
//

import Foundation

struct APIError: Error {
    let code: Int
    let message: String
    let type: APIErroType
    
    enum APIErroType: Int {
        case unknown
        case parsError = 5
        
        init(code: Int) {
            self = APIErroType(rawValue: code) ?? .unknown
        }
    }
    
    init(code: Int, message: String) {
        self.code = code
        self.message = message
        self.type = APIErroType(code: code)
    }
    
    init(error: Error) {
        self.message = error.localizedDescription
        let code = (error as NSError).code
        self.code = code
        self.type = APIErroType(code: code)
    }
    
    static let parsError = APIError(code: APIErroType.parsError.rawValue, message: "Unable to pars model")
}
