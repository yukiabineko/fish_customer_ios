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
    @IBOutlet weak var mail_validate: UILabel!
    @IBOutlet weak var pass_validate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mail_field.delegate = self
        pass_field.delegate = self
        
    }
    func isValidEmail(_ string: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let result = emailTest.evaluate(with: string)
            return result
     }
    @IBAction func login(_ sender: Any)
    {
        if(mail_field.text == "" && pass_field.text == ""){
            mail_validate.isHidden = false
            mail_validate.text = "必須です"
            pass_validate.isHidden = false
        }
        else if(mail_field.text == "" && !(pass_field.text == "")){
            mail_validate.isHidden = false
            mail_validate.text = "必須です"
            pass_validate.isHidden = true
        }
        else if(pass_field.text == "" && !(mail_field.text == "")){
            pass_validate.isHidden = false
            mail_validate.text = "必須です"
            mail_validate.isHidden = true
        }
        else if(isValidEmail(mail_field.text!) == false && !(mail_field.text == "")){
            mail_validate.text = "正しい入力をお願いします"
            mail_validate.isHidden = false
        }
        else if(!(mail_field.text == "") && !(pass_field.text == "")){
            mail_validate.isHidden = true
            mail_validate.text = "必須です"
            pass_validate.isHidden = true
            
            
            
            
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}
