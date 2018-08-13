//
//  LoginViewController.swift
//  MiviTest
//
//  Created by amit on 07/08/18.
//  Copyright © 2018 amit. All rights reserved.
//

import UIKit
let  appDelegateShared = UIApplication.shared.delegate as! AppDelegate
class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var textfieldServiceCode: UITextField!
    @IBOutlet var bottomConst : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collection
        if let path = Bundle.main.path(forResource: "collection", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String:Any] {
                    print("jsonResult \(jsonResult)")
                    appDelegateShared.collectionObj = jsonResult
                }
            } catch {
                // handle error
            }
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        textfieldServiceCode.text = ""
        self.navigationController?.isNavigationBarHidden = true
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override  func viewWillDisappear(_ animated: Bool) {
       self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func loginPressed(_ sender: UIButton) {
        if (textfieldServiceCode.text?.isEmpty)! {
        // show alert
            let alertController = UIAlertController(title: title, message: "Service code can not be empty.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            if let arrIncluded = appDelegateShared.collectionObj["included"] as? [[String:Any]], arrIncluded.count > 0, let servicesAttributes =  arrIncluded[0]["attributes"] as? [String:Any] {
                if textfieldServiceCode.text == servicesAttributes["msn"] as? String {
                    self.performSegue(withIdentifier: "showwelcome", sender: nil)
                } else {
                    let alertController = UIAlertController(title: title, message: "Invalid Service code. Please enter MSN service code.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    // MARK: Textfield Delegates
    @IBAction func hideKeyboard(_ sender: Any) {
        textfieldServiceCode?.resignFirstResponder()
        let btn  = UIButton()
        self.loginPressed(btn)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(hideKeyboard(_:)))
        toolbarDone.items = [barBtnDone]
        textField.inputAccessoryView = toolbarDone
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
