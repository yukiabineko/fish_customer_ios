//
//  OrdersViewController.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/13.
//

import UIKit

class OrdersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let sessionTitle = ["本日受け取り商品", "明日の予約商品"]
    var todayOrder:Array<Any> = []
    var tomorrowOrder:Array<Any> = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todayOrder = MyData().todayOrders().today
        tomorrowOrder = MyData().todayOrders().tomorrow

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sessionTitle.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sessionTitle[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return todayOrder.count
        case 1:
            return tomorrowOrder.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableViewCell
        print(todayOrder)
        print(tomorrowOrder)
       
        switch indexPath.section {
        case 0:
            if(todayOrder.count > 0){
                let todayRow = todayOrder[indexPath.row] as! Dictionary<String, Any>
                cell.setOrderItem(
                    name: todayRow["name"] as! String,
                    price: String(describing: todayRow["price"]!),
                    num: String(describing: todayRow["num"]!),
                    process: todayRow["process"] as! String,
                    status:String(describing: todayRow["status"]!),
                    time:String(describing: todayRow["receiving_time"]!)
                    
                )
            }
        case 1:
            if(tomorrowOrder.count > 0){
                let tommorowRow = tomorrowOrder[indexPath.row] as! Dictionary<String, Any>
                cell.setOrderItem(
                    name: tommorowRow["name"] as! String,
                    price: String(describing: tommorowRow["price"]!),
                    num: String(describing: tommorowRow["num"]!),
                    process: tommorowRow["process"] as! String,
                    status:String(describing: tommorowRow["status"]!),
                    time:String(describing: tommorowRow["receiving_time"]!)
                )
            }
        default:
            break
        }
      return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
