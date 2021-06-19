//
//  TestimonialsTblViewCell.swift
//  Vidyanjali
//
//  Created by Vikram Jagad on 24/11/20.
//  Copyright © 2020 Vikram Jagad. All rights reserved.
//

import UIKit

class TestimonialsTblViewCell: UITableViewCell {
    //MARK:- Interface Builder
    //UIView
    @IBOutlet weak var viewImgView: UIView!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var viewSeparator: UIView!
    
    //UIImageView
    @IBOutlet weak var imgView: UIImageView!
    
    //UILabel
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblAuthorDesignation: UILabel!
    
    //NSLayoutConstraint
    @IBOutlet weak var imgViewHeightConstraint: NSLayoutConstraint!
    
    //MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }
    
    //MARK:- Private Methods
    fileprivate func setUpCell() {
        selectionStyle = .none
        setUpLbls()
        //setUpConstraints()
        setUpViews()
        setUpImgView()
    }
    
    fileprivate func setUpLbls() {
        lblTitle.textColor = .black
        lblTitle.font = .systemFont(ofSize: 14)
        
        lblAuthor.textColor = .blue
        lblAuthor.font = .systemFont(ofSize: 16)
        
        lblAuthorDesignation.textColor = .systemGray
        lblAuthorDesignation.font = .systemFont(ofSize: 10)
    }
    
    /*fileprivate func setUpConstraints() {
        let heightOfImgView = ((((SCREEN_WIDTH - (IS_IPAD ? (2 * IPAD_MARGIN) : 0)) - (2 * Constants.Dashboard.testimonialsLeadingTrailingInsets)) * Constants.Dashboard.testimonialsWidthMultiplier) * Constants.Dashboard.testimonialsImgViewMultiplier).rounded(.up)
        imgViewHeightConstraint.constant = heightOfImgView
    }*/
    
    fileprivate func setUpViews() {
        //viewShadow.addShadow()
        //viewShadow.subviews.first?.viewWith(radius: 16)
        
        viewSeparator.backgroundColor = .blue
        
        viewImgView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        //viewImgView.viewWith(radius: (imgViewHeightConstraint.constant + 8)/2)
    }
    
    fileprivate func setUpImgView() {
        //imgView.viewWith(radius: 16)
    }
    
    func configureCell(data: DashboardTestimonialsModel) {
        lblTitle.text = data.title
        lblAuthor.text = data.desc
        lblAuthorDesignation.text = data.id
        //imgView.webImage(with: URL(string: data.img), placeholderImage: .ic_dashboard_testimonial_placeholder)
    }
}
