//
//  AddResourceController.swift
//  ReadIt-IOS
//
//  Created by rajashrk on 8/3/15.
//  Copyright (c) 2015 rajashrk. All rights reserved.
//

import Foundation
import UIKit

class AddResourceController :UITableViewController
{

    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    func getTitle() -> String{
        let titleCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow:0, inSection: 0)) as! TextInputTableViewCell
        let title = titleCell.getText()
        return title
    
    }
    
    func getLink() -> String{
        let linkCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow:0, inSection: 1)) as! TextInputTableViewCell
        let link =  linkCell.getText()
        return link;
        
    }
    
    func clearCells(){
    
        var cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow:0, inSection: 0)) as! TextInputTableViewCell
        cell.textField.text = ""
        cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow:0, inSection: 1)) as! TextInputTableViewCell
         cell.textField.text = ""
        
    }
    
    @IBAction func addResource(sender: AnyObject) {
        
        let title = self.getTitle();
        let link = self.getLink();
        
        if title.isEmpty || link.isEmpty {
            self.showAlert("Oops", message: "Values canot be null")
            return
        }
        var parameters = ["title":title, "link":link] as Dictionary<String, String>
        self.post(parameters)
        self.clearCells()
    
    }
    
    
    
    func post(jsonData : NSDictionary) {
        
        var urlString = "http://readit.thoughtworks.com/resources"
        var request = NSMutableURLRequest(URL:NSURL(string:urlString)!)
        var session = NSURLSession.sharedSession();
        request.HTTPMethod = "POST"
       
        
        var err : NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(jsonData, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            if data != nil {
                var json = NSJSONSerialization.JSONObjectWithData(data , options: NSJSONReadingOptions.MutableContainers, error:nil) as? NSDictionary
                if err != nil{
                    println(err?.localizedDescription)
                    return
                }
                if let httpResponse = response as? NSHTTPURLResponse{
                    if httpResponse.statusCode != 201 {
                        self.showAlert("Oops", message:error.localizedDescription)
                        return
                    }
                }
            }
            
            if error != nil{
                self.showAlert("Oops", message:error.localizedDescription)
                return
            }
            
        }

    }
    func showAlert(title : String, message : String)
    {
        var alert = UIAlertView(title:title, message:message, delegate: nil, cancelButtonTitle: "OK")
        alert.show();
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell  = tableView.dequeueReusableCellWithIdentifier("InputCell") as! TextInputTableViewCell
        if indexPath.section == 0  {
           cell.configure("", placeholder: "Enter title")
        }
        if indexPath.section == 1 {
            cell.configure("", placeholder: "Enter link")
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell;
    
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
}



extension AddResourceController : UITextFieldDelegate{
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
}