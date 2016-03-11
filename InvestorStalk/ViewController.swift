//
//  ViewController.swift
//  InvestorStalk
//
//  Created by Laif Harwood on 11/13/15.
//  Copyright © 2015 LaifHarwood. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = barColor
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor.whiteColor()
        navigationBarAppearance.barTintColor = barColor
        if let titleFont = UIFont(name: "HelveticaNeue", size: 15){
            navigationBarAppearance.titleTextAttributes = [NSFontAttributeName: titleFont, NSForegroundColorAttributeName: UIColor.whiteColor()]
            
        }
        
        let tabBarControllerMain = UITabBarController()
        
        let allFilingsController = AllFilingsViewController()
        let filingsNav = UINavigationController(rootViewController: allFilingsController)
        
        let searchController = SearchViewController()
        let searchNav = UINavigationController(rootViewController: searchController)
        
        let followingController = FollowingViewController()
        let followingNav = UINavigationController(rootViewController: followingController)
        
        let tabItemControllers = [filingsNav, searchNav, followingNav]
        tabBarControllerMain.viewControllers = tabItemControllers
        
        let filingsImage = UIImage(named: "filings")
        let searchImage = UIImage(named: "search")
        let followingImage = UIImage(named: "following")
        
        
        allFilingsController.tabBarItem = UITabBarItem(title: "Filings", image: filingsImage, tag: 1)
        searchController.tabBarItem = UITabBarItem(title: "Search", image: searchImage, tag: 2)
        followingController.tabBarItem = UITabBarItem(title: "Following", image: followingImage, tag: 3)
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarControllerMain
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

