//
//  API.swift
//  Atlas testTask
//
//  Created by Oleksii Karpenko on 1/17/19.
//  Copyright © 2019 Oleksii Karpenko. All rights reserved.
//

import Moya

typealias JSON = [String: Any]

final class APIHost {
    static let host = URL(string: "https://restcountries.eu/rest/v2/")!
}

protocol APIRequestParameters {
    var parameters: JSON { get }
}

extension APIRequestParameters {
    var parameters: JSON { return JSON() }
}
