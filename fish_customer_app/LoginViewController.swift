//
//  LoginViewController.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/07.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var mail_field: UITextField!
    @IBOutlet weak var pass_field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(item_data as Any)
        
        mail_field.delegate = self
        pass_field.delegate = self
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}
