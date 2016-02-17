//
//  ViewController.swift
//  TinyNetwork
//
//  Created by Jeffrey Kereakoglow on 2/16/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import UIKit

struct GithubProfile {
  let login: String
  let id: Int
  let avatarURL: NSURL
}

let makeGithubProfile = { GithubProfile(login: $0, id: $1, avatarURL: $2) }

class ViewController: UIViewController {

  func defaultFailureHandler(failureReason: Reason, data: NSData?) {
    let string = NSString(data: data!, encoding: NSUTF8StringEncoding)
    print("Failure: \(failureReason) \(string)")
  }

  func parseString(data: NSData) -> String? {
    return String(data: data, encoding: NSUTF8StringEncoding)
  }

  func zen() -> Resource<String> {
    return Resource(
      path: Github.Zen,
      method: Method.GET,
      requestBody: nil,
      headers: [:],
      parser: parseString
    )
  }

  func parseGithubProfile(dict: JSONDictionary) -> GithubProfile? {
    return curry(makeGithubProfile) <*> string(dict, key: "login")
      <*> int(dict, key: "id")
      <*> url(dict, key: "avatar_url")
  }


  func request<A>(resource: Resource<A>, completionHandler: A -> ()) {
    let authorizationToken = ""
    let baseURL = NSURL(string: "https://api.github.com")!

    func setAuthToken(request: NSMutableURLRequest) {
      request.setValue("token \(authorizationToken)", forHTTPHeaderField: "Authorization")
    }
    
    apiRequest(
      requestModifier: setAuthToken,
      baseURL: baseURL,
      resource: resource,
      failure: defaultFailureHandler,
      completion: completionHandler
    )
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let baseURL = NSURL(string: "https://api.github.com")!

    apiRequest(
      requestModifier: { _ in },
      baseURL: baseURL,
      resource: zen(),
      failure: defaultFailureHandler,
      completion: { message in
        print("Got a message: \(message)")
      }
    )
  }
}

