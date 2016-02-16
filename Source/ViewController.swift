//
//  ViewController.swift
//  TinyNetwork
//
//  Created by Jeffrey Kereakoglow on 2/16/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import UIKit

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

  override func viewDidLoad() {
    super.viewDidLoad()

    let baseURL = NSURL(string: "https://api.github.com")!

    apiRequest(
      requestModifier: { _ in },
      baseURL: baseURL,
      resource: zen(),
      failure: defaultFailureHandler) { message in
        print("Got a message: \(message)")
    }
  }
}

