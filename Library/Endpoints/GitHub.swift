//
//  GitHub.swift
//  TinyNetwork
//
//  Created by Chris Eidhof on 8/17/14.
//  Copyright (c) 2014 Chris Eidhof. All rights reserved.
//
// http://chris.eidhof.nl/posts/typesafe-url-routes-in-swift.html

import Foundation

enum Github {
  case Zen
  case User
  case UserProfile(String)
}

extension Github: Path {
  var path: String {
    switch self {
    case .Zen: return "/zen"
    case .User: return "/user"
    case .UserProfile(let name): return "/users/\(name)"
    }
  }
}