//
//  Dictionary+Extension .swift
//  HelperClass_Struct_Functions
//
//  Created by Ravi Patel on 26/04/21.
//

import Foundation


extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}
