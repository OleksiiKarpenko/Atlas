//
//  NSObjectExtension.swift
//  Atlas testTask
//
//  Created by Oleksii Karpenko on 1/14/19.
//  Copyright © 2019 Oleksii Karpenko. All rights reserved.
//

import Foundation

extension NSObject {
    static var typeName: String { return String(describing: self) }
}
