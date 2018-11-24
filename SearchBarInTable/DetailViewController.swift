//
//  DetailViewController.swift
//  SearchBarInTable
//
//  Created by pasin on 14/11/2561 BE.
//  Copyright © 2561 Xiaodan Wang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var labelFood: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageRan: UIImageView!
    //    @IBOutlet weak var lablePrice: UILabel!
    
    var image = UIImage()
    var name = ""
    var num = 0
    let randomArray = ["s10","s20","s30"]
    
    
    enum MovieType: String {
        case Fantasy = "120 kg."
        case scifi = "100 kg."
        case Horror = "150 kg."
        case Monster = "200 kg."
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelFood.text = "\(name)"
        //lablePrice.text = "\(MovieType)"
        
        imageView.image = image
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func buyBtn(_ sender: Any) {
        print("Hello word")
        
        num = Int(arc4random_uniform(3))
        imageRan.image = UIImage(named: randomArray[num])
        
    }
    func sale(){
        num = Int(arc4random_uniform(3))
    }
    
}

