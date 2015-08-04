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
    
    var resources = [ReadResource]()
    
    @IBOutlet var resourceListTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
          // Do any additional setup after loading the view, typically from a nib.

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        loadResources();
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        var CancelBarButton = UIBarButtonItem(title:"Cancel", style:UIBarButtonItemStyle.Plain, target:self, action:Selector("loadResources"))
        self.navigationItem.hidesBackButton = true
        self.navigationItem.backBarButtonItem = CancelBarButton;
    }
    
    func loadResources()
    {
        
        resources.removeAll();
        let urlString = "http://readit.thoughtworks.com/resources"
        let url = NSURL(string: urlString);
        let request = NSURLRequest(URL: url!);
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            if data != nil  {
        
                if let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSArray {
                    
                    for dictionary in jsonResult {
                        
                        let title = dictionary["title"] as? String
                        var link  = (dictionary["link"] as? String)!.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil);
                        
                        let escapeUrl = link.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
                        let linkUrl  = NSURL(string:escapeUrl!)!
                        
                        if title != nil && linkUrl.absoluteString != nil
                        {
                            let resource : ReadResource = ReadResource(title: title!, link: linkUrl)
                            self.resources.append(resource);
                        }
                        
                        self.resourceListTable.reloadData()
                    }
                    
                    
                }
                
            }
            if error != nil{
            
                var alert = UIAlertView(title:"Oops", message:error.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
                
                alert.show();
            }
            
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false

        
    }
    
}
extension ResourceViewController:UITableViewDataSource
{
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "resourceCell"
        var cell = resourceListTable.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell
        cell.textLabel?.text = resources[indexPath.row].title;
        
        
        var url :String! = (resources[indexPath.row].link).absoluteString;
        var urlStr : String = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        cell.detailTextLabel?.text = urlStr as String
        return cell;
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count;
    }
}

extension ResourceViewController:UITableViewDelegate
{
    
}

