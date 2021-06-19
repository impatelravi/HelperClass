//
//  OptionalChecking.swift
//  HelperClass_Struct_Functions
//
//  Created by Ravi Patel on 26/04/21.
//

import Foundation

//MARK:- Get Value from Dict
func getInteger(anything: Any?) -> Int
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.intValue
        }
        else if let str = any as? NSString
        {
            return str.integerValue
        }
    }
    return 0
}

func getDouble(anything: Any?) -> Double
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.doubleValue
        }
        else if let str = any as? NSString
        {
            return str.doubleValue
        }
    }
    return 0
}

func getFloat(anything: Any?) -> Float
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.floatValue
        }
        else if let str = any as? NSString
        {
            return str.floatValue
        }
    }
    return 0
}

func getInteger64(anything: Any?) -> Int64
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.int64Value
        }
        else if let str = any as? NSString
        {
            return str.longLongValue
        }
    }
    return 0
}

func getString(anything: Any?) -> String
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.stringValue
        }
        else if let str = any as? String
        {
            return str
        }
        else if let char = any as? Character
        {
            return "\(char)"
        }
    }
    return ""
}

func getBoolean(anything: Any?) -> Bool
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.boolValue
        }
        else if let str = any as? NSString
        {
            return str.boolValue
        }
    }
    return false
}

//MARK:- Print
func DebugLog(_ value: Any?...) {
    if !(isBeta) {
        for value in value {
            if let value = value {
                print(value)
            }
        }
    }
}
