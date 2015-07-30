//
//  ResourcesControllerTest.swift
//  ReadIt-IOS
//
//  Created by rajashrk on 7/29/15.
//  Copyright (c) 2015 rajashrk. All rights reserved.
//

import Foundation


import UIKit
import XCTest

//import ReadIt_IOSTests

class ResourceViewControllerTest : XCTestCase
{
    
    var resourceController : ResourceViewController!
    override func setUp() {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType));
         resourceController = storyboard.instantiateViewControllerWithIdentifier("ResourceController") as! ResourceViewController
        
         let dummy = resourceController.view // force loading subviews and setting outlets
        
         resourceController.viewDidLoad()
    }
    func testResourceTableDelegate(){
      
        XCTAssertNotNil(resourceController.resourceListTable.delegate, "Table view delegate not set")
    }
    func testResourceTableDataSource(){
        
        XCTAssertNotNil(resourceController.resourceListTable.dataSource, "Table view data source not set")
    }
}