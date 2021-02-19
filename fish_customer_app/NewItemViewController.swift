//
//  NewItemViewController.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/07.
//

import UIKit

class NewItemViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lb: UILabel!
    @IBOutlet weak var price_lb: UILabel!
    @IBOutlet weak var stock: UILabel!
    @IBOutlet weak var item_number_field: UITextField!
    @IBOutlet weak var send_button: UIButton!
    @IBOutlet weak var control: UISegmentedControl!
    private var name:String = ""
    private var price: String = ""
    private var stock_num:Int!
    private var process: String = ""
    
     func makeInstance(name: String, price: Int, stock: Int){
       /*let storyboard: UIStoryboard = UIStoryboard(name: "NewItem", bundle: nil)*/
        /*let viewController = storyboard.instantiateViewController(withIdentifier: "NewItem") as! NewItemViewController*/
        self.name = name
        self.price = String(price)
        self.stock_num = stock
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        lb.text = name
        price_lb.text = price
        stock.text = String(stock_num)
        item_number_field.delegate = self
        item_number_field.keyboardType = .numberPad
        if(user_data["name"] == nil){
            send_button.isEnabled = false
            send_button.alpha = 0.5
        }
        process = control.titleForSegment(at: 0)! 
    
    }
    /*キーボード関連*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    /*キーボード関連*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
/*在庫チェック*/
    @IBAction func number_check(_ sender: Any) {
        let stock_num = Int(stock.text!)!
        let input_num = Int(item_number_field.text!)
        if(!(input_num == nil)){
            if( stock_num < input_num!){
                let alert:UIAlertController = UIAlertController(title: "注文数確認", message: "在庫がありません。数量を確認ください。", preferredStyle: .alert)
                let action = UIAlertAction(title: "閉じる", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
    }
/*/在庫チェック*/
    @IBAction func send_order(_ sender: Any) {
        if(!(item_number_field.text!.isEmpty)){
            let id  = String(describing: user_data["id"]!)
            let num = String(item_number_field.text!)
            let url = URL(string: "https://uematsu-backend.herokuapp.com/shopping_phone")!
            var request = URLRequest(url:  url)
            request.httpMethod = "POST"
            request.httpBody = (
                    "id=" + id +
                    "&name=" + name +
                    "&price=" + price +
                    "&num=" + num +
                    "&process=" + process
            ).data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
               
                    let jsons = try! JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
                
                    DispatchQueue.main.sync {
                      
                        if(!(jsons["message"] as! String == "登録しました")){
                            /*サーバー通信成功成功*/
                            let alert:UIAlertController = UIAlertController(title: "確認", message: (jsons["message"] as! String), preferredStyle: .alert)
                            let action = UIAlertAction(title: "閉じる", style: .default, handler: { [self](action: UIAlertAction!)-> Void in
                                
                                DispatchQueue.main.async {
                                    self.navigationController?.popViewController(animated: true)
                                    self.send_button.isEnabled = false
                                }
                               
                            })
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                            
                            
                            
                        }
                        else{
                            /*サーバー通信失敗*/
                            let alert:UIAlertController = UIAlertController(title: "確認", message: (jsons["message"] as! String), preferredStyle: .alert)
                            let action = UIAlertAction(title: "閉じる", style: .default, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                
            })
            task.resume()
        }
        else{
            let alert:UIAlertController = UIAlertController(title: "警告", message: "発注数を入力ください。", preferredStyle: .alert)
            let action = UIAlertAction(title: "閉じる", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    @IBAction func back_menu(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    /*加工法変更*/
    @IBAction func change_process(_ sender: Any) {
        let index = control.selectedSegmentIndex
        let str:String = control.titleForSegment(at: index)!
        process = str
    }
    
    
}
