//
//  OrderTableViewCell.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/14.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var processLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = "testです"
        self.addSubview(mainview)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setOrderItem(name: String, price: String, num: String, process: String, status: String){
        
        nameLabel.text = name
        priceLabel.text = price
        numberLabel.text = num
        processLabel.text = process
    }

}
