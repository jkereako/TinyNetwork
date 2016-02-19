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

  func parseGithubProfile(dict: JSONDictionary) -> GithubProfile? {
    return curry(makeGithubProfile) <*> string(dict, key: "login")
      <*> int(dict, key: "id")
      <*> url(dict, key: "avatar_url")
  }

  /*
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
  failure: GitHubResponse().defaultFailureHandler,
  completion: completionHandler
  )
  }
  */

  override func viewDidLoad() {
    super.viewDidLoad()

    let apiRequest = APIRequest(baseURL: GitHubRequest.baseURL)

    apiRequest.makeRequest(
      requestModifier: nil,
      resource: GitHubRequest().zen(),
      failure: GitHubResponse().defaultFailureHandler,
      completion: { message in
        print("Got a message: \(message)")
      }
    )
  }
}

