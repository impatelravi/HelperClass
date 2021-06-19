//
//  WebServiceConfiguration.swift
//  HelperClass_Struct_Functions
//
//  Created by Ravi Patel on 26/04/21.
//

import UIKit

var isBeta : Bool { return false }

//MARK:- Live
var liveDomain: String { return "http://nhapoa.gov.in/" }

//MARK:- Staging
var stageDomain: String { return "http://139.59.62.134:81/social/" }

fileprivate var BASEURL_Domain: String { return isBeta ? stageDomain : liveDomain }

var BASEURL : String { return BASEURL_Domain + "api/" }

struct WebViewAPI {
    static var aboutUs: String { return BASEURL_Domain + "en/cms/about-us?mview_type=yes" }
    static var contactUs: String { return BASEURL_Domain + "en/cms/contact-us?mview_type=yes" }
}

struct API {
    static let sendOTP = "send-otp"
    static let verifyOTP = "verify-otp"
    static let dashboard = "get-home-banner-list"
    static let notifications = "Users/Notifications"
    static let getGrievance = "get-complaint-list"
    static let getUserDetail = "get-user-detail"
    static let getState = "get-states"
    static let getDistrict = "get-districts"
    static let getTaluka = "get-talukas"
    static let getVictimCategory = "get-victim-category"
    static let getNationality = "get-nationality"
    static let getNearestPoliceStation = "get-nearest-police-station"
    static let getNatureOfGrievance = "get-natureof-grivience"
    static let editProfile = "edit-profile"
    static let getPincode = "get-pincode"
    static let getDocumentList = "get-document-list"
    static let grivienceRegistration = "grivience-registration"
    static let getComplaintDetails = "get-complaint-details"
}

