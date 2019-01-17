//
//  TargetTypeExtension.swift
//  Atlas testTask
//
//  Created by Oleksii Karpenko on 1/17/19.
//  Copyright © 2019 Oleksii Karpenko. All rights reserved.
//

import Moya

extension TargetType {
    var baseURL: URL               { return APIHost.host }
    var path: String               { return "" }
    var method: Method             { return .get  }
    var sampleData: Data           { return Data() }
    var task: Task                 { return .requestPlain }
    var headers: [String: String]? { return nil }
}
