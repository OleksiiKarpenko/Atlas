//
//  CountryRouter.swift
//  Atlas testTask
//
//  Created by Oleksii Karpenko on 1/16/19.
//  Copyright © 2019 Oleksii Karpenko. All rights reserved.
//

import Moya

struct CountryCredentials: APIRequestParameters {
    let regionName: String
    let countryName: String
    let countrysBorderСode: String
}

enum CountryRouter {
    case getCountries(CountryCredentials)
    case searchCountries(CountryCredentials)
    case getCountriesByCode(CountryCredentials)
}

extension CountryRouter: TargetType {
    
    var path: String {
        switch self {
            
        case .getCountries(let credential):
            return APIKeys.region.appending("/\(credential.regionName)")
            
        case .searchCountries(let credential):
            return APIKeys.countryName.appending("/\(credential.countryName)")
        case .getCountriesByCode:
            return APIKeys.countryCode
        }
    }
    
    var task: Task {
        switch self {
            
        case .getCountries, .searchCountries(_):
            return .requestPlain
            
        case .getCountriesByCode(let credential):
            return .requestParameters(parameters: [APIKeys.countryCodeParam: credential.countrysBorderСode], encoding: URLEncoding.default)
        }
    }
}
