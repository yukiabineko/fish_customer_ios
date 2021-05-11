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
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var mailtitle: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var teltitle: UILabel!
    @IBOutlet weak var orderTitle: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    let datas = MyData().orderUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelArray = [nameLabel, nameTitle,orderTitle, orderLabel, mailtitle, teltitle,telLabel,mailLabel]
        for i in 0...labelArray.count-1{
            labelArray[i]?.layer.borderWidth = 1
            labelArray[i]?.layer.borderColor = UIColor.lightGray.cgColor
        }
        if(!(user_data["name"] == nil)){
            print("電話")
            print(user_data["tel"] as! String)
            nameLabel.text = (user_data["name"] as! String)
            mailtitle.text = (user_data["email"] as! String)
            teltitle.text =  (user_data["tel"] as! String)
            orderLabel.text = String(MyData().orderCount())
        }
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameLabel.text = (user_data["name"] as! String)
        mailtitle.text = (user_data["email"] as! String)
        teltitle.text =  (user_data["tel"] as! String)
        orderLabel.text = String(MyData().orderCount())
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
