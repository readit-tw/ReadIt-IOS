//
//  TextInputTableViewCell.swift
//  ReadIt-IOS
//
//  Created by rajashrk on 8/3/15.
//  Copyright (c) 2015 rajashrk. All rights reserved.
//

import Foundation
import UIKit
class TextInputTableViewCell : UITableViewCell
{
   // var isVisible : Bool = false
    
    @IBOutlet weak var textField: UITextField!
    
     func configure(text :String?, placeholder :String?){
    
        textField.text = text;
        textField.placeholder = placeholder;
    }
    
    func getText() -> String{
        
        return textField.text;
    }
    

}


