//
//  ParseTypes.swift
//  TinyNetwork
//
//  Created by Jeffrey Kereakoglow on 2/16/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import Foundation

func array(input: [String: AnyObject], key: String) ->  [AnyObject]? {
  let maybeAny : AnyObject? = input[key]
  return maybeAny >>>= { $0 as? [AnyObject] }
}

func dictionary(input: [String: AnyObject], key: String) ->  [String:AnyObject]? {
  return input[key] >>>= { $0 as? [String:AnyObject] }
}

func string(input: [String: AnyObject], key: String) -> String? {
  return input[key] >>>= { $0 as? String }
}

func number(input: [NSObject: AnyObject], key: String) -> NSNumber? {
  return input[key] >>>= { $0 as? NSNumber }
}

func int(input: [NSObject: AnyObject], key: String) -> Int? {
  return number(input, key: key).map { $0.integerValue }
}

func bool(input: [NSObject: AnyObject], key: String) -> Bool? {
  return number(input, key: key).map { $0.boolValue }
}
