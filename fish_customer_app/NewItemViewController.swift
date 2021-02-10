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
    
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    @IBAction func number_check(_ sender: Any) {
        let stock_num = Int(stock.text!)
        let input_num = Int(item_number_field.text!)
        if(stock_num! < input_num!){
            print("ERROR")
        }
    }
    
}
