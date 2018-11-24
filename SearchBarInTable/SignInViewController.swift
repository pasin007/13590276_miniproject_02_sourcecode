//
//  SignInViewController.swift
//  SearchBarInTable
//
//  Created by pasin on 14/11/2561 BE.
//  Copyright © 2561 Xiaodan Wang. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textUsername.delegate = self
        textPassword.delegate = self

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func btnSignIn(_ sender: UIButton) {
        let myUsername :  String
        myUsername = textUsername.text!
        
        let myPassword : String
        myPassword = textPassword.text!
        
        if(myUsername == "admin" && myPassword == "1234"){
            performSegue(withIdentifier: "homeSegue", sender: nil)
            
            print("you are success")
            
        }else if (myUsername != "admin" && myPassword != "1234"){
            print("you are false")
            
            createAlert(title: "ERROR", message: "Username and Password \n admin and 1234")
            //ProgressHUD.show("รหัสผ่านไม่ถูกต้อง")
            
        }else if(myUsername != "admin"){
            createAlert(title: "ERROR", message: "Username \n admin")
            
        }else if(myPassword != "1234"){
            createAlert(title: "ERROR", message: "Password \n 1234")
            
        }
        
    }
    func createAlert (title: String , message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action)in
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
        
        
    
    
}
