//
//  MockEndpoint.swift
//  TinyNetwork
//
//  Created by Jeffrey Kereakoglow on 2/25/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import Foundation

import Foundation
@testable import TinyNetwork

enum MockEndpoint {
  case TheEnd
  case Zen
}

extension MockEndpoint: Path {
  var path: String {
    switch self {
    case .TheEnd: return "/beautiful-friend"
    case .Zen: return "/zen"
    }
  }
}