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
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = "testです"
        self.addSubview(mainview)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setOrderItem(name: String, price: String, num: String, process: String, status: String, time: String){
        
        if(!(time == "<null>")){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let date = dateFormatter.date(from: time)
            
            dateFormatter.dateFormat = "MM/dd HH:mm"
            dateFormatter.timeZone = TimeZone(identifier:  "Asia/Tokyo")
            let dateString = dateFormatter.string(from: date!)
            timeLabel.text = dateString
            
        }
        else{
            timeLabel.text = ""
        }
        
        nameLabel.text = name
        priceLabel.text = price
        numberLabel.text = num
        processLabel.text = process
        if(status == "0"){
            statusLabel.text = "申請中"
            statusLabel.backgroundColor = UIColor.systemBlue;
        }
        else if(status == "1"){
            statusLabel.text = "加工済み"
            statusLabel.backgroundColor = UIColor.systemOrange;
        }
        else if(status == "2"){
            statusLabel.text = "受け渡し済み"
            statusLabel.backgroundColor = UIColor.systemRed;
        }
    }

}
