//
//  UITableView+Extension.swift
//  HelperClass_Struct_Functions
//
//  Created by Ravi Patel on 26/04/21.
//
//Extension is used for register and deque cell

import UIKit

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}


public extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func register<T: UITableViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(HeaderFooterType: T.Type) {
        let className = HeaderFooterType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: className)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(HeaderFooterTypes: [T.Type]) {
        HeaderFooterTypes.forEach { registerHeaderFooter(HeaderFooterType: $0) }
    }
    
    func dynamicHeightTableHeaderViewCalling() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self,
                  let headerView = self.tableHeaderView else { return }
            var newFrame = headerView.frame
            let size = headerView.systemLayoutSizeFitting(.init(width: self.frame.width, height: 600), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
            newFrame.size = size
            headerView.frame = newFrame
            self.tableHeaderView = headerView
        }
    }
    
    func dynamicHeightTableFooterViewCalling() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self,
                  let headerView = self.tableFooterView else { return }
            var newFrame = headerView.frame
            let size = headerView.systemLayoutSizeFitting(.init(width: self.frame.width, height: 600), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
            newFrame.size = size
            headerView.frame = newFrame
            self.tableFooterView = headerView
        }
    }
}

