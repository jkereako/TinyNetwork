//
//  GitHubProfile.swift
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

// This let's us save JSON, which is represented as a `[String: AnyObject]` dictionary, as a type.
// If we were to use this this with Core Data, then to build the Core Data object would be as simple
// as passing in a `GitHubProfile` instance into the Core Data class `init` method. Because all of
// the properties of `GitHubProfile` are not optional, we can guarantee that the values will always
// exist.
import Foundation

struct GitHubProfile {
  let login: String
  let id: Int
  let avatarURL: NSURL
}

