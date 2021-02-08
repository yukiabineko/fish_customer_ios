//
//  ItemViewController.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/06.
//

import UIKit

/*画像URLから取得*/

extension UIImage {
    public convenience init(url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
        self.init(data: data)!
        return
        } catch let err {
        print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
}

class ItemViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var item_table: UITableView!
    var items: Array<String> = []
    var prices: Array<Int> = []
    var stock: Array<Int> = []
    var imgUrl = "https://yukiabineko.sakura.ne.jp/react/%E3%81%95%E3%82%93%E3%81%BE.jpg"
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemData = item_data[indexPath.row] as! [String:Any]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! ItemTableViewCell
        cell.setStatus(
            image: UIImage(url: imgUrl),
            name: itemData["name"] as! String,
            price: itemData["price"] as! Int
         )
        cell.order.tag = indexPath.row
        cell.order.addTarget(self, action: #selector(new_page_access(_:)), for: .touchUpInside)
        return cell
    }
    @objc func new_page_access(_ sender: UIButton){
        let id = sender.tag
        let viewController = NewItemViewController.makeInstance(str: items[id])
        self.present(viewController, animated: true, completion: nil)
    }
    

}
