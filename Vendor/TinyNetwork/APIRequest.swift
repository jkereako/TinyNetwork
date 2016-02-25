//
//  APIRequest.swift
//
//  http://chris.eidhof.nl/posts/tiny-networking-in-swift.html
//
//  Created by Jeffrey Kereakoglow on 2/16/16.
//  Copyright © 2016 Chris Eidhof
//
//  Licensed under the MIT license:
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software
//  and associated documentation files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or
//  substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
//  BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation

/// Represents a request made to an API, however, any HTTP request can be made with this class.
struct APIRequest {
  let session: NSURLSession
  let baseURL: NSURL

  // Allow for dependency injection to make the class testable
  init(baseURL: NSURL, session: NSURLSession = NSURLSession.sharedSession()) {
    self.session = session
    self.baseURL = baseURL
  }

  func makeRequest<A>(
    requestModifier requestModifier: (NSMutableURLRequest -> ())?, resource: Resource<A>,
    failure: (reason: Reason, data: NSData?) -> (), completion: A -> ()) {

      let url = baseURL.URLByAppendingPathComponent(resource.path.path)
      let request = NSMutableURLRequest(URL: url)

      request.HTTPMethod = resource.method.rawValue
      request.HTTPBody = resource.requestBody

      requestModifier?(request)

      for (key,value) in resource.headers {
        request.setValue(value, forHTTPHeaderField: key)
      }

      let task = session.dataTaskWithRequest(request) {
        (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in

        if let httpResponse = response as? NSHTTPURLResponse {
          switch httpResponse.statusCode {

            // Success!
          case 200...299:
            if let responseData = data {
              if let result = resource.parser(responseData) {
                completion(result)
              }

              else {
                failure(reason: Reason.UnableToParseData, data: data)
              }
            }

            else {
              failure(reason: Reason.NoData, data: data)
            }

            break

            // Redirection
          case 300...399:
            failure(reason: Reason.Redirection(
              httpStatusCode: httpResponse.statusCode), data: data
            )
            break

            // Client error
          case 400...499:
            failure(reason: Reason.ClientError(
              httpStatusCode: httpResponse.statusCode), data: data
            )
            break

            // Server error
          case 500...599:
            failure(reason: Reason.ServerError(
              httpStatusCode: httpResponse.statusCode), data: data
            )
            break

          default:
            break
          }
        }
          
        else {
          failure(reason: Reason.Other(error!), data: data)
        }
      }
      
      task.resume()
  }
}

