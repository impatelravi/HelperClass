//
//  WShandler.swift
//  HelperClass_Struct_Functions
//
//  Created by Ravi Patel on 26/04/21.
//



import UIKit
import Alamofire

typealias WSBlock = (_ json: [String : Any], _ flag: Int) -> ()

//MARK:- Image Type
enum ImageType : String {
    case jpeg
    case JPEG
    case jpg
    case JPG
    case png
    case gif
}


//MARK:- Definition
class WShandler: NSObject {
    //MARK:- Blocks Definition
    var successBlock: (String, AFDataResponse<Any>, WSBlock) -> Void
    var errorBlock: (String, NSError, WSBlock) -> Void
    
    //MARK:- Initilizer WShandler
    override init() {
        successBlock = { (relativePath, respObj, block) -> Void in
            if respObj.response?.statusCode == 200 {
                block(respObj.value as? [String : Any] ?? [:], (respObj.response?.statusCode)!)
            } else if respObj.response?.statusCode == 401 {
                block(respObj.value as? [String : Any] ?? [:], 200)
            } else if ((respObj.response?.statusCode == 404) && !(getString(anything: (respObj.value as? [String : Any])?[CommonAPIConstant.key_message]).isEmptyString)) {
                block(respObj.value as? [String : Any] ?? [:], 200)
            } else if ((respObj.response?.statusCode == 201) && !(getString(anything: (respObj.value as? [String : Any])?[CommonAPIConstant.key_message]).isEmptyString)) {
                block(respObj.value as? [String : Any] ?? [:], 200)
            } else if (respObj.response?.statusCode == 500) {
                block(respObj.value as? [String : Any] ?? [:], 200)
            } else if (respObj.response?.statusCode == 404) {
                block(respObj.value as? [String : Any] ?? [:], 200)
            } else {
                block(respObj.value as? [String : Any] ?? [:], (respObj.response?.statusCode) ?? 0)
            }
        }
        errorBlock = { (relativePath, error, block) -> Void in
            if let data = error.userInfo["com.alamofire.serialization.response.error.data"] as? NSData {
                let errorDict = (try? JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary
                if errorDict != nil {
                    DebugLog("Error(\(relativePath)): \(errorDict!)")
                    block(errorDict as? [String : Any] ?? [:], error.code)
                    
                } else {
                    let msg = "Something strange happened"
                    block(["errormsg" : msg], error.code)
                    DebugLog(msg)
                }
            } else if error.code == -1009 { // happenes when no internet
                DebugLog("Error Object: \(error)")
                block(["errormsg" : "Connection Error"], error.code)
                return
            } else if error.code == -1003  { // happenes when slow internet or slow server
                block(["errormsg": "Your current internet connection is slow, Please try after some time." as AnyObject], error.code)
                return
            } else if error.code == -1001  { // happenes when slow internet or slow server
                DebugLog("Error Object: \(error)")
                block(["errormsg": "The requested timed out"], error.code)
                return
            } else {
                if(error.localizedDescription != "") {
                    block(["errormsg" : "Unexpected problem"], error.code)
                } else {
                    block(["errormsg" : "Unexpected problem"], error.code)
                }
            }
        }
        super.init()
    }
    
    static let shared = WShandler()
}

//jignesh new code added.
//MARK:- Post Requests
extension WShandler {
    
    //MARK:- Post Request With URL
    func postWebRequest(urlStr: String, param: [String : Any]?, block: @escaping WSBlock) {
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        /*if ((UserModel.signedIn) && !(UserModel.currentUser.token.isEmptyString)) {
            header["Authorization"] = "Bearer \(UserModel.currentUser.token)"
        }*/
        AF.request(urlStr, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
//            DebugLog("Response - \(WShandler.JSONStringify(value: response.result.value, prettyPrinted: true))")
            self.apiResponsePrettyPrintedPrint(respObj: response)
            switch (response.result) {
            case .success(_):
                self.successBlock(urlStr, response, block)
            case .failure(let error):
                self.errorBlock(urlStr, error as NSError, block)
            }
        }
    }

    
    func postWebRequestWithFormURLEncoded(urlStr: String, param: [String : Any]?, block: @escaping WSBlock) {
        let header: HTTPHeaders = ["Content-Type" : "application/x-www-form-urlencoded"]
        /*if ((UserModel.signedIn) && !(UserModel.currentUser.token.isEmptyString)) {
            header["Authorization"] = "Bearer \(UserModel.currentUser.token)"
        }*/
        AF.request(urlStr, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
//            DebugLog("Response - \(WShandler.JSONStringify(value: response.result.value, prettyPrinted: true))")
            self.apiResponsePrettyPrintedPrint(respObj: response)
            switch(response.result) {
            case .success(_):
                self.successBlock(urlStr, response, block)
            case .failure(let error):
                self.errorBlock(urlStr, error as NSError, block)
            }
        }
    }
    
    //MARK:- Get Request With URL
    func getWebRequest(urlStr: String, param: [String : Any]?, block: @escaping WSBlock) {
        var url = urlStr
        if let param = param, param.keys.count > 0 {
            url += "?\(param.queryString)"
        }
        let header: HTTPHeaders = [:]
        /*if ((UserModel.signedIn) && !(UserModel.currentUser.token.isEmptyString)) {
            header["Authorization"] = "Bearer \(UserModel.currentUser.token)"
        }*/
        AF.request(url, method: .get, parameters:nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
//            DebugLog("Response - \(WShandler.JSONStringify(value: response.result.value, prettyPrinted: true))")
            self.apiResponsePrettyPrintedPrint(respObj: response)
            switch(response.result) {
            case .success(_):
                self.successBlock(urlStr, response, block)
            case .failure(let error):
                self.errorBlock(urlStr, error as NSError, block)
            }
        }
    }
    
    //MARK:- Multipart Request
    func multipartWebRequest(urlStr: String, dictParams: [String : Any]?, documents: [DocumentModel]?, block: @escaping WSBlock) {
        let header: HTTPHeaders = [:]
        /*if ((UserModel.signedIn) && !(UserModel.currentUser.token.isEmptyString)) {
            header["Authorization"] = "Bearer \(UserModel.currentUser.token)"
        }*/
        AF.upload(multipartFormData: { (multipartFormData) in
            if let params = dictParams {
                for (key, value) in params {
                    if value is [[String : Any]] {
                        multipartFormData.append(WShandler.JSONStringify(value: value).data(using: .utf8)!, withName: key)
                    } else if value is [String : Any] {
                        multipartFormData.append(WShandler.JSONStringify(value: value).data(using: .utf8)!, withName: key)
                    } else {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                }
            }
            if let documents = documents {
                DebugLog("Documents - \(documents)")
                for document in documents {
                    var data: Data?
                    if let url = document.url {
                        data = try? Data(contentsOf: url)
                    } else if let image = document.document as? UIImage {
                        if (document.type.caseInsensitiveCompare(ImageType.png.rawValue) == .orderedSame) {
                            data = image.pngData()
                        } else {
                            data = image.jpegData(compressionQuality: 1.0)
                        }
                    }
                    if let data = data {
                        multipartFormData.append(data, withName: document.key, fileName: document.title + "." + document.type, mimeType: document.mimeType.lowercased())
                    }
                }
            }
        }, to: urlStr, method: .post, headers: header,requestModifier: { (request) in
            request.timeoutInterval = 120
        } ).uploadProgress { (progress) in
            debugPrint(progress.fractionCompleted)
//            uploadProgress?(progress.fractionCompleted)
        }.responseJSON { (response) in
            
            self.apiResponsePrettyPrintedPrint(respObj: response, multipartDataRequest: (dictJson: dictParams, uploadDict: documents))
            
            switch(response.result) {
            case .success(_):
                self.successBlock(urlStr, response, block)
            case .failure(let error):
                self.errorBlock(urlStr, error as NSError, block)
            }
        }
    }
    
    private func apiResponsePrettyPrintedPrint(respObj: AFDataResponse<Any>,
                                               multipartDataRequest: (dictJson:[String:Any]?, uploadDict:[DocumentModel]?)? = nil) {
        #if DEBUG
        
        print("url => ",respObj.request?.url ?? "")
        print("http Method => ",respObj.request?.httpMethod ?? "")
        print("Status Code => ",respObj.response?.statusCode ?? "--nil--")
        
        if let allHTTPHeaderFields = respObj.request?.allHTTPHeaderFields {
            print("HTTP Headers => ")
            if let jsonData = try? JSONSerialization.data(withJSONObject: allHTTPHeaderFields, options: .prettyPrinted) {
                print(NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? allHTTPHeaderFields)
            } else {
                print(allHTTPHeaderFields)
            }
        }
        
        if let httpBody = respObj.request?.httpBody {
            print("Parameter => ")
            if let json = try? JSONSerialization.jsonObject(with: httpBody, options: []),
                let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print(NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? "")
            } else {
                print(NSString(data: httpBody, encoding: String.Encoding.utf8.rawValue) ?? "")
            }
        }
        
        if let getMultipartDataRequest = multipartDataRequest {
            print("MultiPart Parameter => ")
            
            // 1. Pretty Printed Print Like PostMan
//            if let httpBodyJson = getMultipartDataRequest.dictJson {
//                if let jsonData = try? JSONSerialization.data(withJSONObject: httpBodyJson, options: .prettyPrinted) {
//                    print(NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? httpBodyJson)
//                } else {
//                    print(httpBodyJson)
//                }
//            }
            
            // 2. Bulk Edit Print Like PostMan
            if let httpBodyJson = getMultipartDataRequest.dictJson {
                httpBodyJson.sorted(by: { $0.key < $1.key }).forEach({ print("\($0):\($1)") })
                print("")
            }
            
            
            // File Uploads Key Documents
            if let uploadDict = getMultipartDataRequest.uploadDict {
                for uploadItem in uploadDict {
                    
                    print("Document Key => \n", uploadItem.key,
                          "\nDocument URL => \n", uploadItem.url?.absoluteString ?? "",
                          "\nDocument => \n",
                          (uploadItem.document as? NSObject)?.className ?? uploadItem.document ?? "",
                          "\nDocument Title => \n", uploadItem.title,
                          "\nDocument Type => \n", uploadItem.type
                          )
                }
            }
        }
        
        if let getData = respObj.data {
            print("Response => ")
            if let json = try? JSONSerialization.jsonObject(with: getData, options: []),
                let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print(NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? "")
            } else {
                print(NSString(data: getData, encoding: String.Encoding.utf8.rawValue) ?? "")
            }
        }
        
        if let getError = respObj.error {
            print("Error => ")
            print(getError)
        }
        
        #endif
    }
}


//MARK:- Common Methods for APIs
extension WShandler {
    //Common Parameters used in APIs
    /// Common Values to be passed in every API call
    ///
    /// - Returns: Dictionary with Common parameters.
    class func commonDict() -> [String: Any] {
        let parameter: [String : Any] = [CommonAPIConstant.key_languageCode : "English"]//,
                                         //CommonAPIConstant.key_CryptDeviceID: DeviceID]
        return parameter as [String : Any]
    }
    
    //JSON Conversion to Dictionary
    class func JSONStringify(value: Any?, prettyPrinted:Bool = false) -> String {
        if let value = value {
            let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
            if JSONSerialization.isValidJSONObject(value) {
                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: options)
                    if let string = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                        return string
                    }
                } catch {
                    
                }
            }
        }
        return ""
    }
    
    //MARK:- Check Internet Connectivity
    func CheckInternetConnectivity() -> Bool {
        let reachability:Reachability = Reachability()!
        return reachability.isReachable
    }
}
