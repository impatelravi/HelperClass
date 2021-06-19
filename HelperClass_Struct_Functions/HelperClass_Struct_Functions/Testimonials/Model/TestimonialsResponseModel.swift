//
//  TestimonialsResponseModel.swift
//  Vidyanjali
//
//  Created by Vikram Jagad on 24/11/20.
//  Copyright © 2020 Vikram Jagad. All rights reserved.
//

import UIKit

class TestimonialsResponseModel: NSObject {
    let resultFlag: Bool
    let message: String
    let totalCount: Int
    let list: [DashboardTestimonialsModel]
    
    enum Keys: String {
        case list = "testimonialArr"
        case message
    }
    
    init(dict: [String : Any]) {
        resultFlag = getBoolean(anything: dict[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dict[Keys.message.rawValue])
        totalCount = getInteger(anything: dict[CommonAPIConstant.key_totalCount])
        if let arr = dict[Keys.list.rawValue] as? [[String : Any]] {
            list = arr.map({ DashboardTestimonialsModel(dict: $0) })
        } else {
            list = []
        }
        super.init()
    }
}
