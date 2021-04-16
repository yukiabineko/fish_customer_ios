//
//  UserEditViewController.swift
//  fish_customer_app
//
//  Created by abi on 2021/04/15.
//

import UIKit

class UserEditViewController: UIViewController {

    @IBOutlet weak var name_field: UITextField!
    @IBOutlet weak var mail_field: UITextField!
    @IBOutlet weak var pass_field: UITextField!
    @IBOutlet weak var pass_conf_field: UITextField!
    @IBOutlet weak var tel_field: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(user_email)
        print(user_password)
        
        if((user_data["name"]) != nil){
            name_field.text = (user_data["name"] as! String)
            mail_field.text =  (user_data["email"] as! String)
            tel_field.text = (user_data["tel"] as! String)
        }

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func edit_user(_ sender: Any) {
        
        
        let url = URL(string: "https://uematsu-backend.herokuapp.com/users/ios_update")
        var request = URLRequest(url:  url!)
        request.httpMethod = "POST"
        request.httpBody = (
            "id=" + String(describing: user_data["id"]!) +
            "&name=" + name_field.text! +
            "&email=" + mail_field.text! +
            "&oldmail=" + user_email +
            "&oldpass=" + user_password +
            "&tel=" + tel_field.text! +
            "&password=" + pass_field.text! +
            "&password_confirmation=" + pass_conf_field.text!
        ).data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [self] (data, response, error) in
            
            if((data) != nil){
                let jsons = try! JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
                print("データ")
                print(jsons)
            
                if ((jsons["userData"]) != nil){
                    let dictionary = jsons["userData"] as! Dictionary<String, Any>
                   
                    user_data["id"] = dictionary["id"] as AnyObject?
                    user_data["name"] = dictionary["name"] as AnyObject?
                    user_data["email"] = dictionary["email"] as AnyObject?
                    user_data["tel"] = dictionary["tel"] as AnyObject?
                    user_data["orders"] = dictionary["orders"] as AnyObject?
                    print("変更")
                    print(user_data["tel"] as Any)
                    DispatchQueue.main.sync {
                        user_email = mail_field.text!
                        user_password = pass_field.text!
                        let alert:UIAlertController = UIAlertController(title: "確認", message: "編集しました。", preferredStyle: .alert)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
