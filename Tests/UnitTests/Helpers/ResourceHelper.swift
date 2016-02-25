//
//  ResourceHelper.swift
//  TinyNetwork
//
//  Created by Jeffrey Kereakoglow on 2/25/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import Foundation
@testable import TinyNetwork

func stringResource(method method: HTTPMethod, endpoint: MockEndpoint) -> Resource<String> {
  return Resource(
    path: endpoint,
    method: method,
    requestBody: nil,
    headers: [:],
    parser: { (data: NSData) -> String? in
      // We can reasonably rely that this will always return a valid string
      return String(data: data, encoding: NSUTF8StringEncoding)
    }
  )
}
