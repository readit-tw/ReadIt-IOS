//
//  ViewController.swift
//  ReadIt-IOS
//
//  Created by rajashrk on 7/29/15.
//  Copyright (c) 2015 rajashrk. All rights reserved.
//

import UIKit

class ResourceViewController: UIViewController
{
  
    @IBOutlet var resourceListTable: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ResourceViewController:UITableViewDataSource
{

     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "resourceCell"
        var cell = resourceListTable.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell
        cell.textLabel?.text = "Test";
        return cell;
        
    }
    
    
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
}

extension ResourceViewController:UITableViewDelegate
{
    
}

