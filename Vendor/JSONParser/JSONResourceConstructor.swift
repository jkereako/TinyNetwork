//
//  JSONResourceConstructor.swift
//  TinyNetwork
//
//  Created by Jeffrey Kereakoglow on 2/16/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import Foundation

func JSONResourceConstructor<A>(
  path path: Path, method: Method, requestParameters: JSONDictionary, parse: JSONDictionary -> A?)
  -> Resource<A> {
    let f = { decodeJSON($0) >>>= parse }
    let jsonBody = encodeJSON(requestParameters)
    let headers = ["Content-Type": "application/json"]
    return Resource(path: path, method: method, requestBody: jsonBody, headers: headers, parser: f)
}
