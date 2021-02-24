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
    
    @IBAction func add_user(_ sender: Any) {
        var error_messages:Array<String> = []
        var str: String = ""
        
        if(name_field.text == ""){
            error_messages.append("名前は必須です。")
        }
        if(mail_field.text == ""){
            error_messages.append("メールアドレスは必須です。")
        }
        if(isValidEmail(mail_field.text!) == false){
            error_messages.append("メールアドレスが不正です。")
        }
        if(pass_field.text == ""){
            error_messages.append("パスワードは必須です。")
        }
        if(pass_conf_field.text == ""){
            error_messages.append("パスワード確認も必須です。")
        }
        if(!(pass_field.text == pass_conf_field.text)){
            error_messages.append("パスワードが一致しません。")
        }
        /*エラーか登録成功か？*/
        if(error_messages.count > 0){
           
            let orders = NSOrderedSet(array: error_messages)
            let errors = orders.array as! [String]
            for i in 0...errors.count-1{
                str = str + errors[i]  + "\n"
            }
            let attributedString = NSAttributedString(string: str, attributes: [
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
                        NSAttributedString.Key.foregroundColor : UIColor.white,
                        NSAttributedString.Key.backgroundColor : UIColor.red
              ])
                    let alert = UIAlertController(title: "登録失敗", message: "", preferredStyle: .alert)
                     
                    alert.setValue(attributedString, forKey: "attributedMessage")
                     
                    let cancelAction = UIAlertAction(title: "閉じる",
                                                     style: .default) { (action: UIAlertAction!) -> Void in
                    }
            alert.addAction(cancelAction)
                    present(alert, animated: true, completion: nil)
        }
        else{
            print("ok")
        }
    }
    func isValidEmail(_ string: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let result = emailTest.evaluate(with: string)
            return result
     }
    
}
