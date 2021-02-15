//
//  UserViewController.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/15.
//

import UIKit

class UserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orderTitle: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    let datas = MyData().orderUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelArray = [nameLabel, nameTitle,orderTitle, orderLabel]
        for i in 0...labelArray.count-1{
            labelArray[i]?.layer.borderWidth = 1
            labelArray[i]?.layer.borderColor = UIColor.lightGray.cgColor
        }
        if(!(user_data["name"] == nil)){
            nameLabel.text = (user_data["name"] as! String)
            orderLabel.text = String(MyData().orderCount())
        }
       
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyData().orderCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = datas[indexPath.row] as! Dictionary<String, Any>
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.setOrderHistoryData(
            day:  obj["shopping_date"] as! String,
            name: obj["name"] as! String,
            price: String(describing: obj["price"]!),
            num: String(describing: obj["num"]!)
           
        )
        return cell
    }

}
