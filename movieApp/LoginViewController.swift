//
//  LoginViewController.swift
//  movieApp
//
//  Created by Gokul Murugan on 2022-12-08.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email:UITextField!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var passwod:UITextField!
    
    let verifiedEmail = "Gokul.com"
    let verifiedPassword = "1234"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myButton.isEnabled = false
        email.addTarget(self, action: #selector(LoginViewController.didChangeText(_:)), for: .editingChanged)
        passwod.addTarget(self, action: #selector(LoginViewController.didChangeText(_:)), for: .editingChanged)
    }
    
    @objc func didChangeText(_ textField:UITextField){
        if(email.text != "" && passwod.text != ""){
            myButton.isEnabled = true
        }else{
            myButton.isEnabled = false
        }
        
        
    }
    
    
    
    @IBAction func buttonTap(_ sender: Any) {
        
        if(email.text?.lowercased() == verifiedEmail.lowercased() && passwod.text! == verifiedPassword){
            email.text = nil
            passwod.text = nil
            print("Verification Successfull")
            performSegue(withIdentifier: "login", sender: self)
            
        }
        else {
            print("Unsuccessful")
        }
        
    }
    
    
    
}
