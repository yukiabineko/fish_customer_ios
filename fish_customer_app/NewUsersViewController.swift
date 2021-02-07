//
//  NewUsersViewController.swift
//  fish_customer_app
//
//  Created by 植松勇貴 on 2021/02/07.
//

import UIKit

class NewUsersViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var name_field: UITextField!
    @IBOutlet weak var mail_field: UITextField!
    @IBOutlet weak var pass_field: UITextField!
    @IBOutlet weak var pass_conf_field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name_field.delegate = self
        mail_field.delegate = self
        pass_field.delegate = self
        pass_conf_field.delegate = self
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}
