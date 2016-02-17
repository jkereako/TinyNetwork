//
//  GitHubResponse.swift
//  TinyNetwork
//
//  Created by Jeffrey Kereakoglow on 2/17/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import Foundation

struct GitHubResponse {
  func defaultFailureHandler(failureReason: Reason, data: NSData?) {
    let string = String(data: data!, encoding: NSUTF8StringEncoding)

    print("Failure: \(failureReason) \(string)")
  }

  func parseString(data: NSData) -> String? {
    return String(data: data, encoding: NSUTF8StringEncoding)
  }

  func parseGithubProfile(dict: JSONDictionary) -> GithubProfile? {
    return curry(makeGithubProfile)
      <*> string(dict, key: "login")
      <*> int(dict, key: "id")
      <*> url(dict, key: "avatar_url")
  }
}
