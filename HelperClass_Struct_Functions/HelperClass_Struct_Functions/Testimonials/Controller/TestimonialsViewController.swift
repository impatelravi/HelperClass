//
//  TestimonialsViewController.swift
//  Vidyanjali
//
//  Created by Vikram Jagad on 24/11/20.
//  Copyright © 2020 Vikram Jagad. All rights reserved.
//

import UIKit

class TestimonialsViewController: UIViewController {
    //MARK:- Interface Builder
    //UITableView
    @IBOutlet weak var tblView: UITableView!
    
    //MARK:- Variables
    //Private
    fileprivate let webserviceModel = TestimonialsWebserviceModel()
    fileprivate var delegateDataSource: TestimonialsTblViewDelegateDataSource!
    //Public
    var listData: [DashboardTestimonialsModel] = []
    var isPullToRefresh = false
    var refreshControl = UIRefreshControl()
    var offset = 1
    var totalCount = 0
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVC()
    }
    
    //MARK:- Private Methods
    fileprivate func setUpVC() {
        setUpIPadConstraint()
        setUpPullToRefresh()
        getListData()
    }
    
    fileprivate func setUpIPadConstraint() {
        //changeLeadingTrailingForiPad(view: view)
    }
    
    fileprivate func setUpPullToRefresh() {
        //refreshControl = tblView.addRefreshControl(target: self, action: #selector(pullToRefreshCalled(_:)))
        //refreshControl.attributedTitle = NSAttributedString(string: CommonLabels.pull_to_refresh, attributes: [NSAttributedString.Key.font : UIFont.boldValueFont, NSAttributedString.Key.foregroundColor : UIColor.systemGrey])
    }
    
    //MARK:- Public Methods
    func setUpTblView() {
        if (delegateDataSource == nil) {
            delegateDataSource = TestimonialsTblViewDelegateDataSource(arrData: listData, tbl: tblView, delegate: self)
        } else {
            delegateDataSource.reloadData(arrData: listData)
        }
    }
    
    //MARK:- Selector Methods
    @objc fileprivate func pullToRefreshCalled(_ sender: UIRefreshControl) {
        listData = []
        isPullToRefresh = true
        offset = 1
        totalCount = 0
        getListData()
    }
}

//MARK:- TblViewDelegate Methods
extension TestimonialsViewController: TblViewDelegate {
    func tblViewDidSelectCell(tableView: UITableView, atIndexPath: IndexPath) {
        
    }
    
    func tblViewWillDisplayCell(tableView: UITableView, atIndexPath: IndexPath) {
        if ((listData.count >= 10) && (atIndexPath.row == listData.count - 1) && (listData.count < totalCount)) {
            offset += 1
            getListData()
        }
    }
}

//MARK:- Webservice function
extension TestimonialsViewController {
    func getListData() {
        if !(isPullToRefresh) {
            //CustomActivityIndicator.sharedInstance.showIndicator(view: view)
        }
        webserviceModel.offset = offset
        webserviceModel.getList { (json) in
            if (self.isPullToRefresh) {
                self.isPullToRefresh = false
                self.refreshControl.endRefreshing()
            } else {
                //CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
            }
            if let response = json {
                self.totalCount = response.totalCount
                if (self.offset == 1) {
                    self.listData = response.list
                } else {
                    self.listData.append(contentsOf: response.list)
                }
            }
            self.setUpTblView()
        }
    }
}
