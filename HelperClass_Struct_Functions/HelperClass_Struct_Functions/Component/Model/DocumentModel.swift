//
//  DocumentModel.swift
//  HelperClass_Struct_Functions
//
//  Created by Ravi Patel on 26/04/21.
//

import UIKit

class DocumentModel: NSObject {
    var url: URL? = nil
    var title = ""
    var document: Any? = nil
    var type = ""
    var key = ""
    var mimeType = "*/*"
    var date : Date = Date()
    var isEditModeOpen = false
    var fileLastPathName = ""
    
    override init() {
        super.init()
    }
}
