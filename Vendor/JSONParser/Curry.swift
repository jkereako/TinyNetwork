//
//  Curry.swift
//  TinyNetwork
//
//  Created by Jeffrey Kereakoglow on 2/16/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import Foundation


func curry<A,B,R>(f: (A,B) -> R) -> A -> B -> R {
  return { a in { b in f(a,b) } }
}

func curry<A,B,C,R>(f: (A,B,C) -> R) -> A -> B -> C -> R {
  return { a in { b in {c in f(a,b,c) } } }
}

func curry<A,B,C,D,R>(f: (A,B,C,D) -> R) -> A -> B -> C -> D -> R {
  return { a in { b in { c in { d in f(a,b,c,d) } } } }
}