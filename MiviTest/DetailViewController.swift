//
//  DetailViewController.swift
//  MiviTest
//
//  Created by amit on 07/08/18.
//  Copyright © 2018 amit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var lblText: UILabel!
    @IBOutlet var lbltalk: UILabel!
    @IBOutlet var lblPrimaryubScription: UILabel!
    @IBOutlet var lblInternationaText: UILabel!
    @IBOutlet var lblInternationatalk: UILabel!
    @IBOutlet var lblProductPrice: UILabel!
    @IBOutlet var lblProductName: UILabel!
    @IBOutlet var lblExpDate: UILabel!
    @IBOutlet var lblAutorenewal: UILabel!
    @IBOutlet var lblDataBalance: UILabel!
    @IBOutlet var lblEmail: UILabel!
    @IBOutlet var lblContactNo: UILabel!
    @IBOutlet var lblUserName: UILabel!
    var userDict: [String:Any] = [:]
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        if  let DictData = appDelegateShared.collectionObj["data"] as? [String:Any],  let userAttributes =  DictData["attributes"] as? [String:Any] {
            self.userDict = userAttributes
            
            self.configurePersonalData()
            
            self.configureSubscriptionData()
            
            self.configureProductData()
        }
        
    }

    func configurePersonalData() {
        let strName = "\(self.userDict["title"] ?? "") \(self.userDict["first-name"] ?? "") \(self.userDict["last-name"] ?? "")"
        //personal
        lblUserName.text = strName
        lblContactNo.text = self.userDict["contact-number"] as? String
        lblEmail.text = self.userDict["email-address"]  as? String
    }
    
    func configureSubscriptionData() {
        //subscriptions
        if  let arrIncluded = appDelegateShared.collectionObj["included"] as? [[String:Any]], arrIncluded.count > 0, let subscriptionsAttributes =  arrIncluded[1]["attributes"] as? [String:Any] {
            
            lblDataBalance.text = "\(subscriptionsAttributes["included-data-balance"] ?? 0)" //subscriptionsAttributes["included-data-balance"] as? String
            lblExpDate.text = subscriptionsAttributes["expiry-date"] as? String
            
            if let primarySubs = subscriptionsAttributes["primary-subscription"] as? Int, primarySubs == 1 {
                lblPrimaryubScription.text =  "yes"
            } else {
                lblPrimaryubScription.text =  "no"
            }
            
            if let autoRenew = subscriptionsAttributes["auto-renewal"] as? Int, autoRenew == 1 {
                lblAutorenewal.text =  "yes"
            } else {
                lblAutorenewal.text =  "no"
            }
        }
    }
    
    func configureProductData() {
        if  let arrIncluded = appDelegateShared.collectionObj["included"] as? [[String:Any]], arrIncluded.count > 0, let productAttributes =  arrIncluded[2]["attributes"] as? [String:Any] {
            lblProductName.text = productAttributes["name"] as? String
            lblProductPrice.text = "\(productAttributes["price"] ?? 0)"//productAttributes["price"] as? String
            
            if  let txt = productAttributes["unlimited-text"] as? Int, txt == 1 {
                lblText.text =  "yes"
            } else {
                lblText.text =  "no"
            }
            
            if  let talk = productAttributes["unlimited-talk"] as? Int, talk == 1 {
                lbltalk.text =  "yes"
            } else {
                lbltalk.text =  "no"
            }
            
            if  let internationalTxt = productAttributes["unlimited-international-text"] as? Int, internationalTxt == 1 {
                lblInternationaText.text =  "yes"
            } else {
                lblInternationaText.text =  "no"
            }
            
            if  let internationalTalk = productAttributes["unlimited-international-talk"] as? Int, internationalTalk == 1 {
                lblInternationatalk.text =  "yes"
            } else {
                lblInternationatalk.text =  "no"
            }
        }
        
        
        //lblText.text = productAttributes["expiry-date"] as? String
        //lbltalk.text = productAttributes["expiry-date"] as? String
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
