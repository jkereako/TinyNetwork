//
//  JSONHelpers.swift
//  TinyNetwork
//
//  Created by Chris Eidof on 11/07/14.
//  Copyright © 2015 Chris Eidhof
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

// See the accompanying blog post: http://chris.eidhof.nl/posts/tiny-networking-in-swift.html

import Foundation


// Here are some convenience functions for dealing with JSON APIs

typealias JSONDictionary = [String:AnyObject]

func decodeJSON(data: NSData) -> JSONDictionary? {
  do {
    return try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
      as? [String:AnyObject]
  }
  catch {
    print("An error occured")
  }

  return nil
}

func encodeJSON(dict: JSONDictionary) -> NSData? {
  guard !dict.isEmpty else {
    return nil
  }

  do {
    return try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions())
  }

  catch {
    print("An error occured")
  }

  return nil
}

func jsonResource<A>(
  path: Path, method: Method, requestParameters: JSONDictionary, parse: JSONDictionary -> A?)
  -> Resource<A> {
    let f = { decodeJSON($0) >>>= parse }
    let jsonBody = encodeJSON(requestParameters)
    let headers = ["Content-Type": "application/json"]
    return Resource(path: path, method: method, requestBody: jsonBody, headers: headers, parse: f)
}

func flatten<A>(x: A??) -> A? {
  if let y = x {
    return y
  }

  return nil
}

infix operator  >>>= {}

func >>>= <A,B> (optional : A?, f : A -> B?) -> B? {
  return flatten(optional.map(f))
}