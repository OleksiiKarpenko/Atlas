//
//  CountryModel.swift
//  Atlas testTask
//
//  Created by Oleksii Karpenko on 1/14/19.
//  Copyright © 2019 Oleksii Karpenko. All rights reserved.
//

import Foundation
import UIKit

struct CountryModel: Codable {
    var countryNameLatin: String?
    var countryNameNative: String?
    var countryThreeLettersCode: String?
    var countryTwoLettersCode: String?
    var countryFlagUrl: String?
    var countryBorders: [String]?
    var countryLanguages: [LanguageModel]?
    var countryCurrency: [CurrencyModel]?
    
    enum CodingKeys: String, CodingKey {
        case countryNameLatin = "name"
        case countryNameNative = "nativeName"
        case countryThreeLettersCode = "alpha3Code"
        case countryTwoLettersCode = "alpha2Code"
        case countryFlagUrl = "flag"
        case countryBorders = "borders"
        case countryLanguages = "languages"
        case countryCurrency = "currencies"
        
    }
}

struct LanguageModel: Codable {
    var name: String?
}

struct CurrencyModel: Codable {
    var name: String?
}
