//
//  AllFilingsViewController.swift
//  InvestorStalk
//
//  Created by Laif Harwood on 11/13/15.
//  Copyright © 2015 LaifHarwood. All rights reserved.
//

import UIKit
import Alamofire

class AllFilingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView = UITableView()
    var dataObject = [[String : AnyObject]]()
    let refreshTable = UIRefreshControl()
    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.whiteColor()
        self.title = "Filings"
        tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height + 15), style: UITableViewStyle.Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(FilingsCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 200
        //tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        tableView.separatorColor = transparentColor
        let backgroundImage = UIImage(named: "BG")
        tableView.backgroundView = UIImageView(image: backgroundImage)
//        tableView.sectionFooterHeight = 0.1
//        tableView.sectionHeaderHeight = 0.1
        tableView.allowsSelection = false
        
        refreshTable.attributedTitle = NSAttributedString(string: "")
        refreshTable.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshTable)
        
        startActivityIndicator()
        getData()
        
        
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! FilingsCell
        cell.backgroundColor = transparentColor
        cell.container.frame = CGRectMake(20, 20, self.view.frame.width - 40, tableView.rowHeight - 40)
        cell.container.backgroundColor = UIColor.whiteColor()
        
        cell.companyName.layer.zPosition = 2
        cell.container.layer.zPosition = 0
        cell.sideBar.layer.zPosition = 1
        cell.companyIcon.layer.zPosition = 2
        cell.investorIcon.layer.zPosition = 2
        cell.investorName.layer.zPosition = 2
        cell.percent.layer.zPosition = 3
        cell.date.layer.zPosition = 2
        
        cell.sideBar.frame = CGRectMake(20, 20, 50, tableView.rowHeight - 40)
        let width = cell.container.frame.width - cell.sideBar.frame.width - 10
        cell.percent.frame = CGRectMake(cell.container.frame.maxX - width + 50, cell.container.frame.maxY - 55, width - 50, 50)
        
        //let companyIcon = UIButton()
        //let investorIcon = UIButton()
        cell.investorIcon.frame = CGRectMake(cell.container.frame.minX + 5, cell.container.frame.minY + 10, 40, 40)
        
        cell.companyIcon.frame = CGRectMake(cell.container.frame.minX + 5, cell.investorIcon.frame.maxY + 25, 40, 40)
        
        
        let companyImage = UIImage(named: "Company")
        cell.companyIcon.setImage(companyImage, forState: .Normal)
        
        
        let investorImage = UIImage(named: "Investor")
        cell.investorIcon.setImage(investorImage, forState: .Normal)
        
        if let percent = dataObject[indexPath.section]["percent"] as? Double{
            if percent > 5{
                cell.percent.setTitleColor(greenColor, forState: .Normal)
                cell.sideBar.backgroundColor = greenColor
                cell.investmentType.setTitle("Invested In", forState: .Normal)
            }else{
                cell.percent.setTitleColor(redColor, forState: .Normal)
                cell.sideBar.backgroundColor = redColor
                cell.investmentType.setTitle("Divested From", forState: .Normal)
            }
            let percentString = "\(percent)" + "%"
            
            cell.percent.setTitle(percentString, forState: .Normal)
        }
        cell.percent.titleLabel?.font = heavyLarge
        cell.percent.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        cell.percent.addTarget(self, action: "goToSource:", forControlEvents: .TouchUpInside)
        cell.userInteractionEnabled = true
        cell.percent.tag = indexPath.section
        //cell.percent.backgroundColor = UIColor.purpleColor()
        
        //let companyName = UIButton()
        
        cell.companyName.frame = CGRectMake(cell.sideBar.frame.maxX + 5, cell.companyIcon.frame.minY, cell.container.frame.width - cell.sideBar.frame.width - 10, 40)
        cell.investorName.frame = CGRectMake(cell.sideBar.frame.maxX + 5, cell.investorIcon.frame.minY, cell.container.frame.width - cell.sideBar.frame.width - 10, 40)
        
        
        cell.companyName.titleLabel?.font = mediumMedium
        cell.companyName.setTitleColor(UIColor.blackColor(), forState: .Normal)
        cell.companyName.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        
        if let companyNameVar = dataObject[indexPath.section]["companyName"] as? String{
            cell.companyName.setTitle(companyNameVar, forState: .Normal)
        }
        
    
        cell.investorName.titleLabel?.font = heavyMedium
        cell.investorName.setTitleColor(UIColor.blackColor(), forState: .Normal)
        cell.investorName.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        if let investorNameVar = dataObject[indexPath.section]["investorName"] as? String{
            cell.investorName.setTitle(investorNameVar, forState: .Normal)
        }
        
        cell.date.titleLabel?.font = lightObliqueMedium
        cell.date.setTitleColor(grayColor, forState: .Normal)
        cell.date.frame = CGRectMake(cell.companyName.frame.minX, cell.percent.frame.maxY - cell.percent.frame.height - 10, cell.container.frame.width - cell.sideBar.frame.width - 125, cell.percent.frame.height)
        cell.date.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        cell.date.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        //cell.date.backgroundColor = UIColor.blueColor()
        
        
        
        
        //cell.date.setTitle("11.13.15", forState: .Normal)
        
        //print(dataObject[indexPath.section]["date"])
        
        if let date = dataObject[indexPath.section]["date"] as? String{
            
            let year = date.substringWithRange(Range(start: date.startIndex, end: date.startIndex.advancedBy(4)))
            let month = date.substringWithRange(Range(start: date.startIndex.advancedBy(5), end: date.startIndex.advancedBy(7)))
            let day = date.substringWithRange(Range(start: date.startIndex.advancedBy(8), end: date.startIndex.advancedBy(10)))
            
            let finalDate = month + "." + day + "." + year
            cell.date.setTitle(finalDate, forState: .Normal)
            
        }

        cell.investmentType.titleLabel?.font = lightObliqueMedium
        cell.investmentType.setTitleColor(grayColor, forState: .Normal)
        cell.investmentType.frame = CGRectMake(cell.investorName.frame.minX, cell.investorName.frame.maxY - 3, cell.container.frame.width - cell.sideBar.frame.width - 20, 30)
        cell.investmentType.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
    
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataObject.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    func getData(){
        print("Start Request")
        Alamofire.request(.GET, "http://144.38.22.58:3000/api/13d", parameters:["none":"none"])
        //<Laifs-MacBook-Pro>.local
        //144.38.22.58
            
            .responseJSON { response in
                
                //print(response.result.value)
                if let object = response.result.value as! [[String : AnyObject]]?{
                    self.dataObject = object
                    self.stopActivityIndicator()
                    self.refreshTable.endRefreshing()
                }
        }
        
    }
    
    func goToSource(sender: UIButton!){
        print("tapped")
        let sourceVC = SourceViewController()
        if let sourceLink = dataObject[sender.tag]["source"] as? String{
            sourceVC.sourceUrl = sourceLink
            self.navigationController?.pushViewController(sourceVC, animated: true)
        }
    }
    
    func refresh(sender:AnyObject)
    {
        getData()
    }
    
    func startActivityIndicator(){
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        activityIndicator.hidesWhenStopped = true
        activityIndicator.frame = CGRectMake(self.view.frame.width/2 - 25, tableView.frame.height/2 - 70, 50, 50)
        tableView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator(){
        
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }

}
