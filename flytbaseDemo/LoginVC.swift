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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btCalculateClickAction(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CalculatorVC") as! CalculatorVC
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
