//
//  MockURLSessionDataTask.swift
//
//  http://swiftandpainless.com/stubbing-nsurlsession-with-dependency-injection/
//
//  Created by Jeff Kereakoglow on 2/18/16.
//  Copyright © 2016 Dominik Hauser. All rights reserved.
//

import Foundation

class MockURLSessionDataTask: NSURLSessionDataTask {
  typealias Response = (data: NSData?, urlResponse: NSURLResponse?, error: NSError?)
  var mockResponse: Response
  let completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)?

  init(response: Response, completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)?) {
    self.mockResponse = response
    self.completionHandler = completionHandler
  }
  override func resume() {
    completionHandler!(mockResponse.data, mockResponse.urlResponse, mockResponse.error)
  }
}
