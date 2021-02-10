//
//  NewItemViewController.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/07.
//

import UIKit

class NewItemViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lb: UILabel!
    @IBOutlet weak var stock: UILabel!
    @IBOutlet weak var item_number_field: UITextField!
    @IBOutlet weak var send_button: UIButton!
    private var name:String = ""
    private var price:Int!
    private var stock_num:Int!
    
    static func makeInstance(name: String, price: Int, stock: Int)-> NewItemViewController{
        let storyboard: UIStoryboard = UIStoryboard(name: "NewItem", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewItemViewController") as! NewItemViewController
        viewController.name = name
        viewController.price = price
        viewController.stock_num = stock
        return viewController
    }
    @IBAction func back_menu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lb.text = name
        stock.text = String(stock_num)
        item_number_field.delegate = self
        item_number_field.keyboardType = .numberPad
        if(user_data["name"] == nil){
            send_button.isEnabled = false
            send_button.alpha = 0.5
        }
    
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
        
    }
}
