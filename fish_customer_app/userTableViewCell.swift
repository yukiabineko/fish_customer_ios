//
//  UserTableViewCell.swift
//  
//
//  Created by abi on 2021/02/15.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let labels = [dateLabel, nameLabel, priceLabel, numLabel]
        for i in 0...labels.count-1{
            labels[i]?.layer.borderWidth = 1
            labels[i]?.layer.borderColor = UIColor.lightGray.cgColor
        }

        
    }
    func setOrderHistoryData(day: String, name: String, price: String, num: String){
        dateLabel.text = day
        nameLabel.text = name
        priceLabel.text = "価格:   \(price)"
        if num == "<null>"{
            numLabel.text = "注文数  0"
            
        }
        else{
            numLabel.text = "注文数   \(num)"
        }
       
    }

}
