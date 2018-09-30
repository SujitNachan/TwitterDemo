//
//  String.swift
//  TwitterDemo
//
//  Created by Mac on 29/09/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import Alamofire

extension String: ParameterEncoding {
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
}
