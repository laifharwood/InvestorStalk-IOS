//
//  FollowingViewController.swift
//  InvestorStalk
//
//  Created by Laif Harwood on 11/13/15.
//  Copyright © 2015 LaifHarwood. All rights reserved.
//

import UIKit

class FollowingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()

        // Do any additional setup after loading the view.
        let testLabel = UILabel(frame: CGRectMake(20,50, self.view.frame.width, 60))
        testLabel.text = "This is Following"
        testLabel.textColor = UIColor.blackColor()
        self.view.addSubview(testLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
