//
//  itemsViewController.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/06.
//

import UIKit

class itemsViewController: UIViewController {
    let fishs = ["coffee", "tea", "cocoa"] 
    
    @IBOutlet weak var lb: UILabel!
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lb.text = "sample"

    }
}
