//
//  ViewController.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/06.
//

import UIKit

var item_data:Array<Any> = []
var user_data = Dictionary<String,AnyObject>()
var user_email: String = ""
var user_password: String = ""

class ViewController: UIViewController{
    
    @IBOutlet weak var alert_label: UILabel!
    @IBOutlet weak var order_button: UIButton!
    @IBOutlet weak var customer_button: UIButton!
    @IBOutlet weak var login_tag: UIButton!
    var progressArea:UIView!
    var progressLabel:UILabel!
    var progressBar:UIProgressView!
    
    
    /*データモデル*/
    
    struct Items: Codable{
        let name:String
        let price:Int
        let stock:Int
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressArea = UIView.init(frame: CGRect(x: 0, y: self.view.bounds.size.height/3, width: self.view.bounds.size.width, height: self.view.bounds.size.height/10 ))
        progressArea.backgroundColor = UIColor.white
        progressArea.layer.cornerRadius = 4
        progressArea.layer.shadowOpacity = 0.9
        progressArea.layer.shadowRadius = 2
        
        
        progressLabel = UILabel(frame: CGRect(x: 0, y: progressArea.frame.size.height/5, width: progressArea.frame.size.width, height: progressArea.frame.size.height/3))
        progressLabel.text = "しばらくお待ちください。"
        
        progressBar = UIProgressView(frame: CGRect(x: 10, y: progressArea.frame.size.height/1.5, width: progressArea.frame.size.width-20, height: progressArea.frame.size.height/20))
        progressBar.transform = CGAffineTransform(scaleX: 1.0, y: 6.0)
        progressBar.progressTintColor = .blue
        progressBar.setProgress(1.0, animated: true)
        progressBar.progress = 1.0

        
        progressArea.addSubview(progressLabel)
        progressArea.addSubview(progressBar)
        self.view.addSubview(progressArea)
        
        if(item_data.count == 0){
            getOrder() /*オーダー取得*/
        }
       
       
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
        /*if(!(user_data["name"] == nil)){
            let id = user_data["id"] as! Int
            MyData().showUserData(id: id)  /*データの更新*/
            print("テストです")
        }
        */
        
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
            let logoutAction = UIAlertAction(title: "ログアウト", style: .default, handler: { [self](action: UIAlertAction) -> Void in
                user_data.removeAll()
                self.loadView()
                self.viewDidLoad()
                self.login_tag.setTitle("ログイン", for: .normal)
                self.progressArea.isHidden = true
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
/********************************オーダー数********************************************************************************************/
    func getOrder(){
        
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.progressBar.progress = 1.0
                        self.progressArea.isHidden = true
                    }
                    
                }
                else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let alert = UIAlertController(title: "ご案内", message: "情報取得失敗しました。", preferredStyle: .alert)
                        let action = UIAlertAction(title: "閉じる", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                        self.progressBar.progress = 1.0
                        self.progressArea.isHidden = true
                    }
                 
                }
            })
            task.resume()
        }
/********************************オーダー数終了********************************************************************************************/
   }


