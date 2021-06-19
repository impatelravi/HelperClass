//
//  DashboardTestimonialsModel.swift
//  Vidyanjali
//
//  Created by Vikram Jagad on 11/11/20.
//  Copyright © 2020 Vikram Jagad. All rights reserved.
//

import UIKit

class DashboardTestimonialsModel: NSObject {
    /*let title: String
    let id: String
    let img: String
    let author: String
    let authorDesignation: String
    
    enum Keys: String {
        case title = "content"
        case id = "id"
        case img = "image"
        case author = "author_name"
        case authorDesignation = "name"
    }
    
    init(dict: [String : Any]) {
        title = getString(anything: dict[Keys.title.rawValue])
        id = getString(anything: dict[Keys.id.rawValue])
        img = getString(anything: dict[Keys.img.rawValue])
        author = getString(anything: dict[Keys.author.rawValue])
        authorDesignation = getString(anything: dict[Keys.authorDesignation.rawValue])
        super.init()
    }*/
    
    let title: String
    let desc: String
    let decodedStr: NSAttributedString?
    let date: Double
    var isRead : String
    let id : String
    
    //MARK:- Enum
    enum Keys: String {
        case subject = "subject"
        case desc = "description"
        case created_at = "created_at"
        case isRead = "is_read"
        case id = "id"
    }
    
    //MARK:- Initializers
    init(dict: [String : Any]) {
        title = getString(anything: dict[Keys.subject.rawValue])
        desc = getString(anything: dict[Keys.desc.rawValue])
        decodedStr = desc.getDecodedString()
        date = getDouble(anything: dict[Keys.created_at.rawValue])
        isRead = getString(anything: dict[Keys.isRead.rawValue])
        id = getString(anything: dict[Keys.id.rawValue])
    }
}
