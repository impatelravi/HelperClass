//
//  UIViewController+Extension.swift
//  Vidyanjali
//
//  Created by Vikram Jagad on 06/11/20.
//  Copyright © 2020 Vikram Jagad. All rights reserved.
//

import UIKit

enum AppStoryboard: String {
    
    case testimonials = "Testimonials"
    case viewController = "Main"
    
}

extension UIViewController {
    class func instantiate(appStoryboard: AppStoryboard) -> Self {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: Self.self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
