//
//  ParameterEncoding.swift
//  LATCHCodingChallenge
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/8/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
