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
    var progressArea:UIView!
    var progressLabel:UILabel!
    var progressBar:UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        progressArea = UIView.init(frame: CGRect(x: 0, y: self.view.bounds.size.height/3, width: self.view.bounds.size.width, height: self.view.bounds.size.height/10 ))
        progressArea.backgroundColor = UIColor.white
        progressArea.layer.cornerRadius = 6
        progressArea.layer.shadowOpacity = 0.7
        progressArea.layer.shadowRadius = 4
        
        
        progressLabel = UILabel(frame: CGRect(x: 0, y: progressArea.frame.size.height/5, width: progressArea.frame.size.width, height: progressArea.frame.size.height/3))
        progressLabel.text = "ただいまアクセスしてます。"
        
        progressBar = UIProgressView(frame: CGRect(x: 10, y: progressArea.frame.size.height/1.5, width: progressArea.frame.size.width-50, height: progressArea.frame.size.height/20))
        progressBar.transform = CGAffineTransform(scaleX: 1.0, y: 6.0)
        progressBar.progressTintColor = .green
        progressBar.setProgress(1.0, animated: true)
        progressBar.progress = 0.8

        
        progressArea.addSubview(progressLabel)
        progressArea.addSubview(progressBar)
        self.view.addSubview(progressArea)
        
        progressArea.isHidden = true
        
        mail_field.delegate = self
        mail_field.keyboardType = .emailAddress
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
            progressArea.isHidden = false
            progressBar.setProgress(1.0, animated: true)
            
            mail_validate.isHidden = true
            mail_validate.text = "必須です"
            pass_validate.isHidden = true
            
            
            
            let url = URL(string: "https://uematsu-backend.herokuapp.com/sessions")!
            var request = URLRequest(url:  url)
            request.httpMethod = "POST"
            request.httpBody = ("email=" + mail_field.text! + "&password=" + pass_field.text!).data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { [self] (data, response, error) in
               
                if((data) != nil){
                    let jsons = try! JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
                    print("テスト")
                    print(jsons)
                    user_data["id"] = jsons["id"] as AnyObject?
                    user_data["name"] = jsons["name"] as AnyObject?
                    user_data["email"] = jsons["email"] as AnyObject?
                    user_data["tel"] = jsons["tel"] as AnyObject?
                    user_data["orders"] = jsons["orders"] as AnyObject?
                    print(user_data["tel"] as Any)
                    print(user_data["name"] as Any)
                    
                    DispatchQueue.main.sync {
                      
                        if(!(user_data["name"] == nil)){
                            /*サーバー通信成功かつログイン成功*/
                            user_email = mail_field.text!
                            user_password = pass_field.text!
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
                    let mydata = MyData()
                    let datas = mydata.todayOrders()
                    print(datas.today)
                    print("--------------")
                    print(datas.tomorrow)
                    /*print(((user_data["orders"] as! [Any])[0] as! [Any])[2])*/
                }
                DispatchQueue.main.async{
                    self.progressBar.progress = 1.0
                    self.progressArea.isHidden = true
                }
                
            })
            task.resume()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}
