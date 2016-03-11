//
//  FilingsCell.swift
//  InvestorStalk
//
//  Created by Laif Harwood on 11/13/15.
//  Copyright © 2015 LaifHarwood. All rights reserved.
//

import UIKit

class FilingsCell: UITableViewCell {
    
    var companyIcon = UIButton()
    var companyName = UIButton()
    var investorIcon = UIButton()
    var investorName = UIButton()
    var container = UIView()
    var sideBar = UIView()
    var percent = UIButton()
    var date = UIButton()
    var investmentType = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(companyIcon)
        self.contentView.addSubview(companyName)
        self.contentView.addSubview(investorIcon)
        self.contentView.addSubview(investorName)
        self.contentView.addSubview(container)
        self.contentView.addSubview(sideBar)
        self.contentView.addSubview(percent)
        self.contentView.addSubview(date)
        self.contentView.addSubview(investmentType)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        //percent.textColor = UIColor.blackColor()
    }


}
