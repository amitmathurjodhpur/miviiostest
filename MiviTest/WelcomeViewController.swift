//
//  WelcomeViewController.swift
//  MiviTest
//
//  Created by amit on 07/08/18.
//  Copyright © 2018 amit. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet  var lblMsg : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let DictData = appDelegateShared.collectionObj["data"] as? [String:Any], let servicesAttributes =  DictData["attributes"] as? [String:Any] {
            let strName = "\(servicesAttributes["title"] ?? "") \(servicesAttributes["first-name"] ?? "") \(servicesAttributes["last-name"] ?? "")"
          
            let main_string = " Hey! Hello! \(strName) It’s nice to have you around! You’re about to change your life."
            let string_to_color = strName
            
            let range = (main_string as NSString).range(of: string_to_color)
            
            let attribute = NSMutableAttributedString.init(string: main_string)
            attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue , range: range)
            lblMsg.attributedText = attribute
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
