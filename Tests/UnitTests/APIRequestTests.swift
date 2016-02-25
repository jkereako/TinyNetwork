//
//  TinyNetworkTests.swift
//  TinyNetworkTests
//
//  Created by Jeffrey Kereakoglow on 2/16/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import XCTest
@testable import TinyNetwork

class APIRequestTests: XCTestCase {

  let baseURL = NSURL(string: "http://github.com")!
  var apiRequest: APIRequest!

  override func setUp() {
    super.setUp()

    apiRequest = APIRequest(baseURL: baseURL, session: MockURLSession())
  }

  override func tearDown() {
    super.tearDown()

    apiRequest = nil
  }

  func testStringResourceWith200Response() {
    let response = "Winter is coming"
    let data = response.dataUsingEncoding(NSUTF8StringEncoding)!
    let endpoint = MockEndpoint.Zen
    let resource = stringResource(method: HTTPMethod.GET, endpoint: endpoint)
    let url = baseURL.URLByAppendingPathComponent(endpoint.path)

    // Create a URL response
    let urlResponse = NSHTTPURLResponse(
      URL: url, statusCode: 200, HTTPVersion: nil, headerFields: nil
    )

    MockURLSession.mockResponse = (data, urlResponse: urlResponse, error: nil)

    apiRequest.makeRequest(
      requestModifier: nil,
      resource: resource,
      failure: { (reason, data) in
        XCTFail("Given the controls in this test, we should never fail.")
      },
      completion: { result in
        // Ensure the parsed result equals the response
        XCTAssertEqual(result, response)
      }
    )
  }

  func testStringResourceWith404Response() {
    let response = "Winter is coming"
    let data = response.dataUsingEncoding(NSUTF8StringEncoding)!
    let endpoint = MockEndpoint.Zen
    let resource = stringResource(method: HTTPMethod.GET, endpoint: endpoint)
    let url = baseURL.URLByAppendingPathComponent(endpoint.path)

    // Create a URL response
    let urlResponse = NSHTTPURLResponse(
      URL: url, statusCode: 404, HTTPVersion: nil, headerFields: nil
    )

    MockURLSession.mockResponse = (data, urlResponse: urlResponse, error: nil)

    apiRequest.makeRequest(
      requestModifier: nil,
      resource: resource,
      failure: { (reason, data) in
        switch reason {
        case .ClientError(httpStatusCode: 404):
          XCTAssert(true)

        default:
          XCTFail("Expected a client error 404")
        }
      },
      completion: { result in
        XCTFail("Unexpected behavior.")
      }
    )
  }
}
