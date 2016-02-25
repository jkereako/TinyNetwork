//
//  GitHubRequests.swift
//  TinyNetwork
//
//  Created by Jeffrey Kereakoglow on 2/17/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import Foundation

struct GitHubRequest {
  static let baseURL = NSURL(string: "https://api.github.com")!
  func zen() -> Resource<String> {
    return Resource(
      path: Github.Zen,
      method: HTTPMethod.GET,
      requestBody: nil,
      headers: [:],
      parser: GitHubResponse().parseString
    )
  }
}
