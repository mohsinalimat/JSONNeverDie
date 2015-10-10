// The MIT License (MIT)

// Copyright (c) 2015 JohnLui <wenhanlv@gmail.com> https://github.com/johnlui

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//  JSONND.swift
//  JSONNeverDie
//
//  Created by 吕文翰 on 15/10/7.
//

import Foundation

public struct JSONND {
    public var data: AnyObject!
    public static func initWithData(data: NSData) -> JSONND! {
        do {
            return JSONND(data: try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments))
        } catch let error as NSError {
            let e = NSError(domain: "JSONNeverDie.JSONParseError", code: error.code, userInfo: error.userInfo)
            NSLog(e.localizedDescription)
            return JSONND()
        }
    }
    public init() {}
    public init(data: AnyObject!) {
        self.data = data
    }
    public subscript (index: String) -> JSONND {
        if let jsonDictionary = self.data as? Dictionary<String, AnyObject> {
            if let value = jsonDictionary[index] {
                return JSONND(data: value)
            } else {
                NSLog("JSONNeverDie: No such key '\(index)'")
            }
        }
        return JSONND(data: nil)
    }
    public var jsonString: String? {
        get {
            do {
                if let _ = self.data {
                    return NSString(data: try NSJSONSerialization.dataWithJSONObject(self.data, options: .PrettyPrinted), encoding: NSUTF8StringEncoding) as? String
                } else {
                    return nil
                }
            } catch {
                return nil
            }
        }
    }
    public var jsonStringValue: String {
        get {
            return self.jsonString ?? ""
        }
    }
    public var int: Int? {
        get {
            return self.data?.integerValue
        }
    }
    public var intValue: Int {
        get {
            return self.int ?? 0
        }
    }
    public var float: Float? {
        get {
            return self.data?.floatValue
        }
    }
    public var floatValue: Float {
        get {
            return self.float ?? 0
        }
    }
    public var string: String? {
        get {
            return self.data as? String
        }
    }
    public var stringValue: String {
        get {
            return self.string ?? ""
        }
    }
    public var bool: Bool? {
        get {
            return self.data as? Bool
        }
    }
    public var boolValue: Bool {
        get {
            return self.bool  ?? false 
        }
    }
    public var array: [JSONND]? {
        get {
            if let _ = self.data {
                if let arr = self.data as? Array<AnyObject> {
                    var result = Array<JSONND>()
                    for i in arr {
                        result.append(JSONND(data: i))
                    }
                    return result
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
    }
    public var arrayValue: [JSONND] {
        get {
            return self.array ?? [] 
        }
    }
}