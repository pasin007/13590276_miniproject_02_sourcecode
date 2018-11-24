//
//  DetailxxViewController.swift
//  SearchBarInTable
//
//  Created by pasin on 15/11/2561 BE.
//  Copyright © 2561 Xiaodan Wang. All rights reserved.
//

import UIKit

class DetailxxViewController: UIViewController {

    @IBOutlet weak var labelFood: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var image = UIImage()
    var name = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelFood.text = "\(name)"
        imageView.image = image

        // Do any additional setup after loading the view.
    }
    

   

}
