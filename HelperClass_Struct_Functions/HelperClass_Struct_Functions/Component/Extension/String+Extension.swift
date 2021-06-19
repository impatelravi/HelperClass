//
//  StringExtension.swift
//  HelperClass_Struct_Functions
//
//  Created by Ravi Patel on 26/04/21.
//

import UIKit

//Static EmailRegex
let kEmailRegex = "(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*)@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?)"


let passportNoRegex = "^([A-Z]){1}([0-9]){7}$"
let drivingLicenseNoRegex = "^([a-zA-Z]){2}([0-9]){2}([0-9 ]){1}([0-9]){10}$" //"^([0-9a-zA-Z]){15}$"
let voterIdCardNoRegex = "^([a-zA-Z]){3}([0-9]){7}$"
let panCardNoRegex = "^([A-Z]){5}([0-9]){4}([A-Z]){1}$"
let aadharCardNoRegex = "^[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}$"
let rationCardNoRegex = "^([a-zA-Z0-9]){8,16}\\s*$"

extension String {
    var firstUppercased: String
    {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}

extension String
{
    //MARK:- Validation Functions
    //Length validation
    var isEmptyString: Bool {
        return trimming_WS_NL.count == 0
    }
    
    var isValidUrl: Bool {
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with: self)
    }
    
    var isValidPanCard : Bool {
        let regEx = "^([A-Z]){5}([0-9]){4}([A-Z]){1}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with: self)
    }
    
    
    func checkValidWith(regex: String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray: [regex])
        return predicate.evaluate(with: self)
    }
    
    
    var isValidEmail: Bool {
        let emailRegEx = kEmailRegex
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    

    
    
   
}

extension String
{
    var condensedWhitespace: String
    {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var length: Int
    {
        return self.count
    }
    
    subscript (i: Int) -> String
    {
        return self[i ..< (i + 1)]
    }
    
    func substring(from: Int) -> String
    {
        return self[min(from, length) ..< length]
    }
    
    func substring(to: Int) -> String
    {
        return self[0 ..< max(0, to)]
    }
    
    subscript (r: Range<Int>) -> String
    {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        let tempRange = start..<end
        return String(self[tempRange])
    }
}

extension String
{
    func index(from: Int) -> Index
    {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(with r: Range<Int>) -> String
    {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

extension String
{
    //MARK:- For Background Image According to device ratio
    func imageAccordingToRatio() -> UIImage?
    {
        let ratio = CGFloat(UIScreen.main.bounds.size.width)/UIScreen.main.bounds.size.height
        if (String(format : "%.2f",ratio) == "0.56")
        {
            return UIImage(named: "\(self)_56")
        }
        else if (String(format : "%.2f",ratio) == "0.46")
        {
            return UIImage(named: "\(self)_46")
        }
        return UIImage(named: "\(self)_46")
    }
}

extension String
{
    //MARK:- HTML content decoded string
    func getDecodedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        guard let attributedString = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.characterEncoding : String.Encoding.utf8.rawValue,
            NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil) else {
            return nil
        }
        attributedString.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
    var getHtmlToString : String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        guard let attributedString = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.characterEncoding : String.Encoding.utf8.rawValue,

            NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil) else {
            return self
        }
        return attributedString.string
    }
    
}


extension String {
    var isStringEmpty : Bool {
        return !(trimming_WS_NL.count > 0)
    }
    
    var nsString : NSString {
        return NSString(string: self)
    }
    
    var trimming_WS_NL : String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var trimming_WS : String {
        return trimmingCharacters(in: .whitespaces)
    }
    
    var is_trimming_WS_NL_to_String : String? {
        return trimming_WS_NL.count > 0 ? self : nil
    }
    
    var urlUserAllowed: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!
    }
    
}

extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"

        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)

        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }

        return (self as NSString).substring(with: result.range)
    }
    
    //at will be only 0-3.
    func youtubeThumbnail(at: Int) -> String {
        return "http://img.youtube.com/vi/\(youtubeID ?? "")/\(at).jpg"
    }
}
