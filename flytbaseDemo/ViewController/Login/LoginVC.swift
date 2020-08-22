//
//  LoginVC.swift
//  flytbaseDemo
//
//  Created by vaibhav bhosale on 20/08/20.
//  Copyright © 2020 VB. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var tfldUserName: UITextField!
    @IBOutlet weak var tfldPassCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btCalculateClickAction(_ sender: Any) {
        if tfldUserName.text == "" {
            self.showAlert(strMessage: "Please enter user name")
        }
        else if tfldPassCode.text == "" {
            self.showAlert(strMessage: "Please enter passcode")
        }
        else if tfldPassCode.text?.count ?? 0 != 4 {
            self.showAlert(strMessage: "Please enter 4 - digit passcode")
        }
        else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.userNameAnPass = (tfldUserName.text ?? "") + "democal" + ("\(tfldPassCode.text ?? "")".reversed())
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CalculatorVC") as! CalculatorVC
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func showAlert(strMessage:String) {
        let alert = UIAlertController(title: "Alert", message: strMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
