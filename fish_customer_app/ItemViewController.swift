//
//  ItemViewController.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/06.
//

import UIKit

class ItemViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! ItemTableViewCell
        cell.setStatus(
            image: UIImage(named: "aji")!,
            name: items[indexPath.row],
            price: prices[indexPath.row])
        cell.order.tag = indexPath.row
        cell.order.addTarget(self, action: #selector(new_page_access(_:)), for: .touchUpInside)
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
    @objc func new_page_access(_ sender: UIButton){
        let id = sender.tag
        let viewController = NewItemViewController.makeInstance(str: items[id])
        self.present(viewController, animated: true, completion: nil)
    }
    

}
