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
    var imgUrl = "https://yukiabineko.sakura.ne.jp/react/"
    private var cacheCellHeights: [IndexPath: CGFloat] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (item_data.count == 0 ) {
            item_table.isHidden = true
            let lb = UILabel(frame: CGRect(x: self.view.frame.size
                                            .width/3.5, y: self.view.frame.size.height/2, width: self.view.frame.size.width, height: 100))
            lb.text = "データが表示できません"
            self.view.addSubview(lb)
        }
       
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemData = item_data[indexPath.row] as! [String:Any]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! ItemTableViewCell
        
        cell.setStatus(
            image: imgUrl + (itemData["path"] as! String) + ".jpg",
            name: itemData["name"] as! String,
            price: itemData["price"] as! Int
         )
        cell.order.tag = indexPath.row
        cell.order.addTarget(self, action: #selector(new_page_access(_:)), for: .touchUpInside)
        return cell
    }
    
    
    @objc func new_page_access(_ sender: UIButton){
        let id = sender.tag
        let itemData = item_data[id] as! [String:Any]
        let viewController = NewItemViewController.makeInstance(str: itemData["name"] as! String)
        self.present(viewController, animated: true, completion: nil)
    }
    

}
