//
//  Operators.swift
//  TinyNetwork
//
//  Created by Jeffrey Kereakoglow on 2/16/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import Foundation

infix operator  <*> { associativity left precedence 150 }

func <*><A, B>(l: (A -> B)?, r: A?) -> B? {
  if let l1 = l {
    if let r1 = r {
      return l1(r1)
    }
  }
  return nil
}

infix operator  >>>= {}

func >>>= <A,B> (optional : A?, f : A -> B?) -> B? {
  return flatten(optional.map(f))
}
