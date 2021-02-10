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
            pass_validate.isHidden = true
        }
        else if(isValidEmail(mail_field.text!) == false && !(mail_field.text == "") && pass_field.text == "" ){
            mail_validate.text = "正しい入力をお願いします"
            mail_validate.isHidden = false
            pass_validate.isHidden = false
        }
        else if(!(mail_field.text == "") && !(pass_field.text == "") && isValidEmail(mail_field.text!) == true ){
            mail_validate.isHidden = true
            mail_validate.text = "必須です"
            pass_validate.isHidden = true
            
            let url = URL(string: "https://uematsu-backend.herokuapp.com/sessions")!
            var request = URLRequest(url:  url)
            request.httpMethod = "POST"
            request.httpBody = ("email=" + mail_field.text! + "&password=" + pass_field.text!).data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
               
                if((data) != nil){
                    let jsons = try! JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
                    user_data["name"] = jsons["name"] as AnyObject?
                    user_data["email"] = jsons["email"] as AnyObject?
                    DispatchQueue.main.sync {
                      
                        if(!(user_data["name"] == nil)){
                            /*サーバー通信成功かつログイン成功*/
                            let alert:UIAlertController = UIAlertController(title: "確認", message: "ログインしました。", preferredStyle: .alert)
                            let action = UIAlertAction(title: "閉じる", style: .default, handler: {(action: UIAlertAction!)-> Void in
                                self.navigationController?.popViewController(animated: true)
                            })
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                        else{
                            /*サーバー通信成功かつログイン失敗*/
                            let alert:UIAlertController = UIAlertController(title: "確認", message: "認証失敗。", preferredStyle: .alert)
                            let action = UIAlertAction(title: "閉じる", style: .default, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                        
                    }
                    
                }
            })
            task.resume()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}
