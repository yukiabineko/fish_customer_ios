//
//  NewItemViewController.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/07.
//

import UIKit

class NewItemViewController: UIViewController {

    @IBOutlet weak var lb: UILabel!
    private var str: String!
    
    static func makeInstance(str: String)-> NewItemViewController{
        let storyboard: UIStoryboard = UIStoryboard(name: "NewItem", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewItemViewController") as! NewItemViewController
        viewController.str = str
        return viewController
    }
    @IBAction func back_menu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lb.text = str
    
    }
    
}
