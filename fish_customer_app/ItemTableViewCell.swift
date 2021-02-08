//
//  ItemTableViewCell.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/07.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var fishImage: UIImageView!
    @IBOutlet weak var fishname: UILabel!
    @IBOutlet weak var fishprice: UILabel!
    @IBOutlet weak var order: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.addSubview(mainView)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setStatus(image: UIImage, name: String, price: Int){
        fishImage.image = image
        fishname.text = name
        fishprice.text = String(price)
    }
}

