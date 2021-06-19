//
//  TestimonialsTblViewDelegateDataSource.swift
//  Vidyanjali
//
//  Created by Vikram Jagad on 24/11/20.
//  Copyright © 2020 Vikram Jagad. All rights reserved.
//

import UIKit

@objc protocol TblViewDelegate {
    @objc optional func tblViewDidSelectCell(tableView: UITableView, atIndexPath: IndexPath)
    @objc optional func tblViewWillDisplayCell(tableView: UITableView, atIndexPath: IndexPath)
}

class TestimonialsTblViewDelegateDataSource: NSObject {
    //MARK:- Variables
    //Private
    fileprivate var arrSource: [DashboardTestimonialsModel]
    fileprivate let tblView: UITableView
    fileprivate let delegate: TblViewDelegate
    
    //MARK:- Initializer
    init(arrData: [DashboardTestimonialsModel], tbl: UITableView, delegate: TblViewDelegate) {
        arrSource = arrData
        tblView = tbl
        self.delegate = delegate
        super.init()
        setUp()
    }
    
    //MARK:- Private Methods
    fileprivate func setUp() {
        setUpColView()
    }
    
    fileprivate func setUpColView() {
        registerCell()
        tblView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    fileprivate func registerCell() {
        tblView.register(cellType: TestimonialsTblViewCell.self)
    }
    
    //MARK:- Public Methods
    func reloadData(arrData: [DashboardTestimonialsModel]) {
        arrSource = arrData
        tblView.reloadData()
    }
}

//MARK:- UITableViewDelegate Methods
extension TestimonialsTblViewDelegateDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate.tblViewWillDisplayCell?(tableView: tableView, atIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.tblViewDidSelectCell?(tableView: tableView, atIndexPath: indexPath)
    }
}

//MARK:- UITableViewDataSource Methods
extension TestimonialsTblViewDelegateDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: TestimonialsTblViewCell.self, for: indexPath)
        cell.configureCell(data: arrSource[indexPath.row])
        return cell
    }
}
