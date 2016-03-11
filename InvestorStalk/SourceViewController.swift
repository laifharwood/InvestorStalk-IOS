//
//  SourceViewController.swift
//  InvestorStalk
//
//  Created by Laif Harwood on 11/14/15.
//  Copyright © 2015 LaifHarwood. All rights reserved.
//

import UIKit

class SourceViewController: UIViewController {
    
    var sourceUrl = String()
    
   
    override func viewDidLoad() {
        
        let webView = UIWebView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        self.view.addSubview(webView)
        let url = NSURL(string: sourceUrl)
        let requestObj = NSURLRequest(URL: url!)
        webView.loadRequest(requestObj)
    }
}
