//
//  ItemViewController.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/06.
//

import UIKit

class ItemViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! ItemTableViewCell
        cell.setStatus(
            image: UIImage(named: "aji")!,
            name: items[indexPath.row],
            price: prices[indexPath.row])
        return cell
    }
    
    let items = ["あじ", "さんま", "さば"]
    let prices = ["100", "99", "380"]
    let images = [
       UIImage(named: "aji"),
       UIImage(named: "saba"),
       UIImage(named: "sn")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
   

}
