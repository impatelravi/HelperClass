//
//  TestimonialsWebserviceModel.swift
//  Vidyanjali
//
//  Created by Vikram Jagad on 24/11/20.
//  Copyright © 2020 Vikram Jagad. All rights reserved.
//

import UIKit
import BRYXBanner

class TestimonialsWebserviceModel: NSObject {
    //MARK:- Variables
    //Public
    var offset = 1
    //Private
    fileprivate var listUrl: String {
        return BASEURL + API.notifications
    }
    fileprivate var listDict: [String : Any] {
        return [CommonAPIConstant.key_offset: offset,
                CommonAPIConstant.key_limit: "10"]
    }
    
    //MARK:- Enum
    enum Keys: String {
        case message
    }
    
    //MARK:- Public Methods
    func getList(block: @escaping ((TestimonialsResponseModel?) -> Swift.Void)) {
        if (WShandler.shared.CheckInternetConnectivity()) {
            WShandler.shared.getWebRequest(urlStr: listUrl, param: listDict) { (json, flag) in
                var responseModel: TestimonialsResponseModel?
                if (flag == 200) {
                    if (getBoolean(anything: json[CommonAPIConstant.key_resultFlag])) {
                        responseModel = TestimonialsResponseModel(dict: json)
                    } else {
                        showBanner(message: getString(anything: json[Keys.message.rawValue]))
                    }
                } else {
                    showBanner(message: getString(anything: json[CommonAPIConstant.key_errormsg]))
                }
                block(responseModel)
            }
        } else {
            block(nil)
            showBanner(message: "Internet_Issue")
        }
    }
}

func showBanner(title: String? = nil, message: String, img: UIImage? = nil, bgColor: UIColor = .systemPurple) {
    let banner = Banner(title: title, subtitle: message, image: img, backgroundColor: bgColor, didTapBlock: nil)
    banner.titleLabel.textColor = .white
    banner.titleLabel.font = .boldSystemFont(ofSize: 16)
    banner.detailLabel.textColor = .white
    banner.detailLabel.font = .systemFont(ofSize: 14)
    banner.dismissesOnTap = true
    banner.dismissesOnSwipe = true
    banner.show(nil, duration: 1.5)
}
