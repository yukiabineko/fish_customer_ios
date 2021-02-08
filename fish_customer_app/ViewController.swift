//
//  ViewController.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/06.
//

import UIKit

var item_data:Array<Any> = []

class ViewController: UIViewController{
    
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
               print("データ")
                if((data) != nil){
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
      }
}

