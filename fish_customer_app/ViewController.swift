//
//  ViewController.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/06.
//

import UIKit

var item_data:Array<Any> = []
var user_data = Dictionary<String,AnyObject>()

class ViewController: UIViewController{
    
    @IBOutlet weak var alert_label: UILabel!
    @IBOutlet weak var order_button: UIButton!
    @IBOutlet weak var customer_button: UIButton!
    @IBOutlet weak var login_tag: UIButton!
    /*データモデル*/
    
    struct Items: Codable{
        let name:String
        let price:Int
        let stock:Int
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(item_data.count == 0){
            let url = URL(string: "https://uematsu-backend.herokuapp.com/orders")!
            let request = URLRequest(url:  url)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
              
                if((data) != nil){
                    if(!(item_data.count == 0)){
                        item_data.removeAll()
                    }
                    let jsons = try! JSONDecoder().decode([Items].self, from: data!)
                    
                    for i in 0...jsons.count-1{
                        let name = jsons[i].name
                        /*日本語変換*/
                        let encodeUrlString: String = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                        
                        item_data.append([
                            "name": name,
                            "price": jsons[i].price,
                            "stock": jsons[i].stock,
                            "path": encodeUrlString
                        ])
                    }
                }
                
            })
            task.resume()
        }
    /* if(item_data.count == 0)文終了↑*/
    }
/********************viewDidload終了↑*******************************/
/********************viewWillapper開始*******************************/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

            switch user_data["name"] {
                case nil:
                    alert_label.isHidden = false
                    order_button.isEnabled = false
                    customer_button.isEnabled = false
                    login_tag.setTitle("ログイン", for: .normal)
                default:
                    alert_label.text = "こんにちは\(String(describing: user_data["name"]!))さん"
                    order_button.isEnabled = true
                    customer_button.isEnabled = true
                    login_tag.setTitle("ログアウト", for: .normal)
                   
                }
        }
/********************viewWillapper終了*******************************/
    @IBAction func session_action(_ sender: Any) {
        if(login_tag.titleLabel?.text == "ログイン"){
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        else{
            let alert:UIAlertController = UIAlertController(title: "ログアウト", message: "ログアウトしますよろしいでしょうか？", preferredStyle: .alert)
            let action = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
            let logoutAction = UIAlertAction(title: "ログアウト", style: .default, handler: {(action: UIAlertAction) -> Void in
                user_data.removeAll()
                self.loadView()
                self.viewDidLoad()
                let checkAlert = UIAlertController(title: "確認", message: "ログアウトしました。", preferredStyle: .alert)
                let closeAction = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
                checkAlert.addAction(closeAction)
                self.present(checkAlert, animated: true, completion: nil)
            })
            alert.addAction(logoutAction)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
/*************************session_action終了**********************************************/
    
}

