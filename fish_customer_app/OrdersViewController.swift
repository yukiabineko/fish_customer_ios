//
//  OrdersViewController.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/13.
//

import UIKit

class OrdersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let sessionTitle = ["本日受け取り商品", "明日の予約商品"]
    let todayOrder = MyData().todayOrders().today
    let tomorrowOrder = MyData().todayOrders().tomorrow
   
    override func viewDidLoad() {
        super.viewDidLoad()

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
        let todayRow = todayOrder[indexPath.row] as! Dictionary<String, Any>
        /*let tommorowRow = tomorrowOrder[indexPath.row] as! Dictionary<String, Any>*/
        switch indexPath.section {
        case 0:
            cell.setOrderItem(
                name: todayRow["name"] as! String,
                price: String(describing: todayRow["price"]!),
                num: String(describing: todayRow["num"]!),
                process: todayRow["process"] as! String,
                status:String(describing: todayRow["status"]!)
                
            )
        /*case 1:
            cell.setOrderItem(
                name: tommorowRow["name"] as! String,
                price: tommorowRow["price"] as! String,
                num: tommorowRow["num"] as! String,
                process: tommorowRow["process"] as! String,
                status: tommorowRow["status"] as! String
                
            )
 */
        default:
            break
        }
      return cell
    }
    
}
