//
//  Coders.swift
//  TinyNetwork
//
//  Created by Jeffrey Kereakoglow on 2/16/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import Foundation

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
