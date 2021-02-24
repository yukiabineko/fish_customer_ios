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
    @IBOutlet weak var time_field: UITextField!
    private var name:String = ""
    private var price: String = ""
    private var stock_num:Int!
    private var process: String = ""
    private var order_time: String = ""
    
    //UIDatePickerを定義するための変数
    var datePicker: UIDatePicker = UIDatePicker()
    
    
    func makeInstance(name: String, price: Int, stock: Int){
       /*let storyboard: UIStoryboard = UIStoryboard(name: "NewItem", bundle: nil)*/
        /*let viewController = storyboard.instantiateViewController(withIdentifier: "NewItem") as! NewItemViewController*/
        self.name = name
        self.price = String(price)
        self.stock_num = stock
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        time_field.inputView = datePicker
        
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 80))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        
        // インプットビュー設定(紐づいているUITextfieldへ代入)
        time_field.inputView = datePicker
        time_field.inputAccessoryView = toolbar

        
        
    
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
    // UIDatePickerのDoneを押したら発火
    @objc func done() {
        time_field.endEditing(true)

        // 日付のフォーマット
        let formatter = DateFormatter()

        //"yyyy年MM月dd日"を"yyyy/MM/dd"したりして出力の仕方を好きに変更できるよ
        formatter.dateFormat = "HH:mm"

        //(from: datePicker.date))を指定してあげることで
        //datePickerで指定した日付が表示される
        time_field.text = "\(formatter.string(from: datePicker.date))"

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
            let time = String(time_field.text!)
            let url = URL(string: "https://uematsu-backend.herokuapp.com/shopping_phone")!
            var request = URLRequest(url:  url)
            request.httpMethod = "POST"
            request.httpBody = (
                    "id=" + id +
                    "&name=" + name +
                    "&price=" + price +
                    "&num=" + num +
                    "&process=" + process +
                    "&time=" + time
            ).data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if(!(data == nil)){
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
                }/*dataあるか検証*/
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
    @IBAction func tilme_open(_ sender: Any) {
        
    }
    
    
}
