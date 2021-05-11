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
    @IBOutlet weak var tel_field: UITextField!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name_field.delegate = self
        mail_field.delegate = self
        pass_field.delegate = self
        tel_field.delegate = self
        pass_conf_field.delegate = self
        pass_field.isSecureTextEntry = true
        pass_conf_field.isSecureTextEntry = true
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        if(isValidTel(tel_field.text!) == false){
            error_messages.append("電話番号が不正です。")
        }
        if(mail_field.text == ""){
            error_messages.append("電話番号は必須です。")
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
        /*チェック完了して無事登録できる処理*/
        else{
            let url = URL(string: "https://uematsu-backend.herokuapp.com/users")!
            var request = URLRequest(url:  url)
            request.httpMethod = "POST"
            request.httpBody = (
                "name=" + name_field.text! +
                "&email=" + mail_field.text! +
                "&tel=" + tel_field.text! +
                "&password=" + pass_field.text! +
                "&password_confirmation=" + pass_conf_field.text!
            ).data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { [self] (data, response, error) in
                
                if((data) != nil){
                    let jsons = try! JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
                    
                
                    if ((jsons["userData"]) != nil){
                        let dictionary = jsons["userData"] as! Dictionary<String, Any>
                       
                        user_data["id"] = dictionary["id"] as AnyObject?
                        user_data["name"] = dictionary["name"] as AnyObject?
                        user_data["email"] = dictionary["email"] as AnyObject?
                        user_data["tel"] = dictionary["tel"] as AnyObject?
                        user_data["orders"] = dictionary["orders"] as AnyObject?
                        print(user_data)
                        DispatchQueue.main.sync {
                            user_email = mail_field.text!
                            user_password = pass_field.text!
                            let alert:UIAlertController = UIAlertController(title: "確認", message: "登録しました。", preferredStyle: .alert)
                            let action = UIAlertAction(title: "閉じる", style: .default, handler: {(action: UIAlertAction!)-> Void in
                                self.navigationController?.popViewController(animated: true)
                            })
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    else{
                        let obj = jsons["message"] as! Array<Any>
                        DispatchQueue.main.sync {
                            var message:String = ""
                            for i in 0...obj.count-1{
                                message += obj[i] as! String + "\n"
                            }
                            let alert:UIAlertController = UIAlertController(title: "確認", message: message, preferredStyle: .alert)
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
    /*メールアドレスの正規表現*/
    func isValidEmail(_ string: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let result = emailTest.evaluate(with: string)
            return result
     }
    /*電話番号の正規表現*/
    func isValidTel(_ string: String) -> Bool {
            let telRegEx = "^\\d{2,4}\\d{1,4}\\d{4}$"
            let telTest = NSPredicate(format:"SELF MATCHES %@", telRegEx)
            let result = telTest.evaluate(with: string)
            return result
     }
    
}
