//
//  MockURLSession.swift
//
//  http://swiftandpainless.com/stubbing-nsurlsession-with-dependency-injection/
//
//  Created by Jeff Kereakoglow on 2/18/16.
//  Copyright © 2016 Dominik Hauser. All rights reserved.
//

import Foundation

class MockURLSession: NSURLSession {
  var completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)?

  static var mockResponse: (
  data: NSData?, urlResponse: NSURLResponse?, error: NSError?
  ) = (data: nil, urlResponse: nil, error: nil)

  override class func sharedSession() -> NSURLSession {
    return MockURLSession()
  }
  override func dataTaskWithURL(url: NSURL) -> NSURLSessionDataTask {
    return MockURLSessionDataTask(
      response: MockURLSession.mockResponse, completionHandler: completionHandler
    )

  }

  override func dataTaskWithURL(
    url: NSURL, completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)?)
    -> NSURLSessionDataTask {

      self.completionHandler = completionHandler

      return MockURLSessionDataTask(
        response: MockURLSession.mockResponse, completionHandler: completionHandler
      )
  }

  override func dataTaskWithRequest(request: NSURLRequest) -> NSURLSessionDataTask {
    return MockURLSessionDataTask(
      response: MockURLSession.mockResponse, completionHandler: completionHandler
    )

  }

  override func dataTaskWithRequest(
    request: NSURLRequest, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void)
    -> NSURLSessionDataTask {

      return MockURLSessionDataTask(
        response: MockURLSession.mockResponse, completionHandler: completionHandler
      )
      
  }
}
